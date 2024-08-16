<?php

namespace App\Http\Controllers;

use App\Models\Lawyer;
use App\Models\Member;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;

class UserSearchController extends Controller
{
    // Search for users (members and lawyers)
    public function search(Request $request)
    {
        $query = $request->input('query');

        // Search for lawyers by name or specialization
        $lawyers = Lawyer::where('name', 'like', '%' . $query . '%')
            ->orWhereHas('profile', function($q) use ($query) {
                $q->where('specialization', 'like', '%' . $query . '%');
            })
            ->with('profile')
            ->get();

        // Search for members by name
        $members = Member::where('name', 'like', '%' . $query . '%')
            ->with('profile')
            ->get();

        // Convert to collections if they aren't already
        $lawyerResults = $lawyers instanceof Collection ? $lawyers : collect($lawyers);
        $memberResults = $members instanceof Collection ? $members : collect($members);

        // Format the response to include the account type and user information
        $lawyerResults = $lawyerResults->map(function ($lawyer) {
            return [
                'id' => $lawyer->id,
                'name' => $lawyer->name,
                'email' => $lawyer->email,
                'account_type' => 'lawyer',
                'profile' => [
                    'specialization' => $lawyer->profile->specialization ?? 'N/A',
                    'image' => $lawyer->profile->image ? '/storage/' . $lawyer->profile->image : null,
                ]
            ];
        });

        $memberResults = $memberResults->map(function ($member) {
            return [
                'id' => $member->id,
                'name' => $member->name,
                'email' => $member->email,
                'account_type' => 'member',
                'profile' => [
                    'work' => $member->profile->work ?? 'N/A',
                    'image' => $member->profile->image ? '/storage/' . $member->profile->image : null,
                ]
            ];
        });

        // Combine the results from both searches
        $results = collect($lawyerResults)->merge(collect($memberResults));


        // Combine the results from both searches
        //$results = $lawyerResults->merge($memberResults);
        //$mergedPosts = $toMerge->merge($posts);

        // Return the combined results
        return response()->json([
            'status' => true,
            'data' => $results
        ]);
    }
}
