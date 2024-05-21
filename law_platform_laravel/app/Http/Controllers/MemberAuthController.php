<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
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
            "email" => "required|string|email|unique:users",
            "password" => "required|confirmed" // password_confirmation
        ]);

        // Member model to save user in database
        Member::create([
            "name" => $request->name,
            "email" => $request->email,
            "password" => bcrypt($request->password)
        ]);

        // Response
        return response()->json([
            "status" => true,
            "message" => "User registered successfully"
        ]);
    }

    // Login (POST - email, password)
    public function login(Request $request){

        // Validation
        $request->validate([
            "email" => "required|string|email",
            "password" => "required"
        ]);

        // Check user by email
        $user = Member::where("email", $request->email)->first();

        // Check user by password
        if(!empty($user)){

            if(Hash::check($request->password, $user->password)){

                // Login is ok
                $tokenInfo = $user->createToken("myToken");

                $token = $tokenInfo->plainTextToken; // Token value

                return response()->json([
                    "status" => true,
                    "message" => "Login successful",
                    "token" => $token
                ]);
            }else{

                return response()->json([
                    "status" => false,
                    "message" => "Password didn't match."
                ]);
            }
        }else{

            return response()->json([
                "status" => false,
                "message" => "Invalid credentials"
            ]);
        }
    }

    // Profile (GET, Auth Token)
    // public function profile(){

    //     $userData = auth()->user();

    //     return response()->json([
    //         "status" => true,
    //         "message" => "Profile information",
    //         "data" => $userData
    //     ]);
    // }

    // Logout (GET, Auth Token)
    public function logout(){

        // To get all tokens of logged in user and delete that
        request()->user()->tokens()->delete();

        return response()->json([
            "status" => true,
            "message" => "User logged out"
        ]);
    }

    // Refresh Token (GET, Auth Token)
    public function refreshToken(){

        $tokenInfo = request()->user()->createToken("myNewToken");

        $newToken = $tokenInfo->plainTextToken; // Token value

        return response()->json([
            "status" => true,
            "message" => "Refresh token",
            "access_token" => $newToken
        ]);
    }
}
