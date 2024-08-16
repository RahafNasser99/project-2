<?php

namespace App\Http\Controllers;

use App\Models\Lawyer;
use App\Models\Member;
use App\Models\MemberProfile;
use Illuminate\Http\Request;

class MemberProfileController extends Controller
{
    // View Own Profile (GET, Auth Token)
    public function viewProfile(Request $request)
    {
        $user = $request->user();
        $profile = $user->profile;

        if (!$profile) {
            // Create a new profile with default values
            $profile = MemberProfile::create([
                'member_id' => $user->id,
                'work' => 'Default Work',
                'biography' => 'Default Biography',
                'image' => null,
            ]);
        }

        return response()->json([
            'status' => true,
            'message' => 'Profile retrieved successfully',
            'data' => [
                'member' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'profile' => [
                        'work' => $profile->member->profile->work ?? 'N/A',
                        'image' => $profile->member->profile->image ? '/storage/' . $profile->member->profile->image : null,
                    ],
                ]
            ]
        ]);
    }


    // Edit Own Profile (PUT, Auth Token)
    public function editProfile(Request $request)
    {
        $user = $request->user();
        $profile = $user->profile;

        $request->validate([
            'work' => 'required|string|max:255',
            'biography' => 'required|string|max:1000',
            'image' => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('profile_images', 'public');
        }

        if ($profile) {
            $profile->update([
                'work' => $request->work,
                'biography' => $request->biography,
                'image' => $request->hasFile('image') ? $imagePath : $profile->image,
            ]);
        } else {
            $profile = MemberProfile::create([
                'member_id' => $user->id,
                'work' => $request->work,
                'biography' => $request->biography,
                'image' => $request->hasFile('image') ? $imagePath : null,
            ]);
        }

        return response()->json([
            'status' => true,
            'message' => 'Profile updated successfully',
            'data' => $profile
        ]);
    }

    // View Another Member's Profile (GET, Auth Token)
    public function viewMemberProfile($id)
    {
        $member = Member::find($id);

        if (!$member) {
            return response()->json([
                'status' => false,
                'message' => 'Member not found'
            ], 404);
        }

        $profile = $member->profile;

        if (!$profile) {
            return response()->json([
                'status' => false,
                'message' => 'Profile not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Profile retrieved successfully',
            'data' => [
                'id' => $member->id,
                'name' => $member->name,
                'email' => $member->email,
                'profile' => [
                    'work' => $profile->work ?? 'N/A',
                    'image' => $profile->image ? '/storage/' . $profile->image : null,
                ],
            ]
        ]);
    }

    // View Lawyer's Profile (GET, Auth Token)
    public function viewLawyerProfile($id)
    {
        $lawyer = Lawyer::find($id);

        if (!$lawyer) {
            return response()->json([
                'status' => false,
                'message' => 'Lawyer not found'
            ], 404);
        }

        $profile = $lawyer->profile; // Assuming Lawyer has a profile relationship

        if (!$profile) {
            return response()->json([
                'status' => false,
                'message' => 'Profile not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Profile retrieved successfully',
            'data' => [

                'id' => $lawyer->id,
                'name' => $lawyer->name,
                'email' => $lawyer->email,
                'profile' => [
                    'specialization' => $profile->lawyer->profile->specialization ?? 'N/A',
                    'image' => $profile->lawyer->profile->image ? '/storage/' . $profile->lawyer->profile->image : null,
                ]
            ]
        ]);
    }

}
