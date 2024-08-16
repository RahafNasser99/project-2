<?php

namespace App\Http\Controllers;

use App\Models\Lawyer;
use App\Models\Rating;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RatingController extends Controller
{
    // Store a new rating for a lawyer
    public function rateLawyer(Request $request, $lawyerId)
    {
        $request->validate([
            'rating' => 'required|numeric|min:1|max:5',
        ]);

        $lawyer = Lawyer::findOrFail($lawyerId);
        $user = Auth::user();

        // Check if the user has already rated this lawyer
        $existingRating = Rating::where('lawyer_id', $lawyerId)
            ->where('user_id', $user->id)
            ->where('user_type', get_class($user))
            ->first();

        if ($existingRating) {
            // Update existing rating
            $existingRating->update(['rating' => $request->input('rating')]);
        } else {
            // Create new rating
            Rating::create([
                'lawyer_id' => $lawyer->id,
                'user_id' => $user->id,
                'user_type' => get_class($user),
                'rating' => $request->input('rating'),
            ]);
        }

        return response()->json([
            'status' => true,
            'message' => 'Rating submitted successfully',
        ]);
    }

    // Get the final rating of a lawyer
    public function getLawyerRating($lawyerId)
    {
        $lawyer = Lawyer::findOrFail($lawyerId);
        $finalRating = $lawyer->calculateRating();

        return response()->json([
            'status' => true,
            'rating' => $finalRating,
        ]);
    }

}
