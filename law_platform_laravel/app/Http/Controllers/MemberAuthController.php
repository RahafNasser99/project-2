<?php

namespace App\Http\Controllers;

use App\Models\Lawyer;
use App\Models\MemberProfile;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\Member;

class MemberAuthController extends Controller
{
    // Register (POST - name, email, password)
    public function register(Request $request){

        // Validation
        $request->validate([
            "name" => "required|string",
            "email" => "required|string|email|unique:members",
            "password" => "required|string|min:8|confirmed" // password_confirmation
        ]);

        // Create a new Member instance and save it to the database
        $member = Member::create([
            "name" => $request->name,
            "email" => $request->email,
            "password" => bcrypt($request->password)
        ]);

        // Create a MemberProfile for the newly created member
        MemberProfile::create([
            'member_id' => $member->id,
            'work' => 'Default Work',
            'biography' => 'Default Biography',
            'image' => null,
        ]);

        // Create a token for the newly registered member
        $token = $member->createToken('authToken')->plainTextToken;

        // Response
        return response()->json([
            "status" => true,
            "message" => "User registered successfully",
            "token" => $token
        ]);
    }


    // Login (POST - email, password)
    public function login(Request $request){

        // Validation
        $request->validate([
            "email" => "required|string|email",
            "password" => "required|string"
        ]);

        // Check user by email
        $user = Member::where("email", $request->email)->first();

        // Check user by password
        if ($user && Hash::check($request->password, $user->password)) {
            // Login is ok
            $token = $user->createToken("authToken")->plainTextToken;

            return response()->json([
                "status" => true,
                "message" => "Login successful",
                "token" => $token
            ]);
        } else {
            return response()->json([
                "status" => false,
                "message" => "Invalid credentials"
            ]);
        }
    }


    // Logout (GET, Auth Token)
    public function logout(){

        // To get all tokens of logged-in user and delete that
        request()->user()->tokens()->delete();

        return response()->json([
            "status" => true,
            "message" => "User logged out"
        ]);
    }

    // Refresh Token (GET, Auth Token)
    public function refreshToken(){

        $token = request()->user()->createToken("authToken")->plainTextToken;

        return response()->json([
            "status" => true,
            "message" => "Token refreshed",
            "token" => $token
        ]);
    }

    // Update Account (PUT, Auth Token)
    public function update(Request $request)
    {
        $user = $request->user();

        // Validation
        $request->validate([
            "name" => "required|string|max:255",
            "email" => "required|string|email|max:255|unique:members,email," . $user->id,
            "password" => "nullable|string|min:8|confirmed"
        ]);

        // Update user details
        $user->update([
            "name" => $request->name,
            "email" => $request->email,
            "password" => $request->password ? bcrypt($request->password) : $user->password,
        ]);

        return response()->json([
            "status" => true,
            "message" => "Account updated successfully.",
            "data" => $user
        ]);
    }

    // Delete Account
    public function destroy(Request $request)
    {
        $user = $request->user();
        $user->tokens()->delete(); // Revoke all tokens
        $user->delete(); // Delete user account

        return response()->json([
            'status' => true,
            'message' => 'Account deleted successfully'
        ]);
    }

    // View All Users (GET, Auth Token)
    public function viewAllUsers()
    {
        $users = Member::all();

        return response()->json([
            'status' => true,
            'message' => 'All members retrieved successfully',
            'data' => $users
        ]);
    }

    // View Specific User (GET, Auth Token)
    public function viewUser($id)
    {
        $user = Member::find($id);

        if (!$user) {
            return response()->json([
                'status' => false,
                'message' => 'Member not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Member retrieved successfully',
            'data' => $user
        ]);
    }

    // View All Lawyers (GET, Auth Token)
    public function viewAllLawyers()
    {
        $lawyers = Lawyer::all();

        return response()->json([
            'status' => true,
            'message' => 'All lawyers retrieved successfully',
            'data' => $lawyers
        ]);
    }

    // View Specific Lawyer (GET, Auth Token)
    public function viewLawyer($id)
    {
        $lawyer = Lawyer::find($id);

        if (!$lawyer) {
            return response()->json([
                'status' => false,
                'message' => 'Lawyer not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Lawyer retrieved successfully',
            'data' => $lawyer
        ]);
    }
}
