<?php

namespace App\Http\Controllers;

use App\Models\LegalAdvice;
use App\Models\LegalAdviceComment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LegalAdviceCommentController extends Controller
{
    // Add a comment
    public function store(Request $request, $legalAdviceId)
    {
        $request->validate([
            'comment' => 'required|string',
        ]);

        $legalAdvice = LegalAdvice::findOrFail($legalAdviceId);

        $comment = LegalAdviceComment::create([
            'legal_advice_id' => $legalAdvice->id,
            'lawyer_id' => Auth::id(),
            'comment' => $request->comment,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Comment added successfully',
            'data' => $comment,
        ]);
    }

    // Update a comment
    public function update(Request $request, $id)
    {
        $request->validate([
            'comment' => 'required|string',
        ]);

        $comment = LegalAdviceComment::findOrFail($id);

        if ($comment->lawyer_id !== Auth::id()) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized',
            ], 403);
        }

        $comment->update([
            'comment' => $request->comment,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Comment updated successfully',
            'data' => $comment,
        ]);
    }

    // Delete a comment
    public function destroy($id)
    {
        $comment = LegalAdviceComment::findOrFail($id);

        if ($comment->lawyer_id !== Auth::id()) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized',
            ], 403);
        }

        $comment->delete();

        return response()->json([
            'status' => true,
            'message' => 'Comment deleted successfully',
        ]);
    }

    // View all comments for a specific legal advice
    public function index($legalAdviceId)
    {
        // Load comments along with the lawyer who made each comment and their profile
        $comments = LegalAdviceComment::where('legal_advice_id', $legalAdviceId)
            ->with('lawyer.profile')
            ->get();

        // Format the response to include the commenter information
        $commentsData = $comments->map(function ($comment) {
            return [
                'id' => $comment->id,
                'comment' => $comment->comment,
                'created_at' => $comment->created_at,
                'updated_at' => $comment->updated_at,
                'lawyer' => [
                    'id' => $comment->lawyer->id,
                    'name' => $comment->lawyer->name,
                    'email' => $comment->lawyer->email,
                    'profile' => [
                        'image' => $comment->lawyer->profile->image
                            ? '/storage/' . $comment->lawyer->profile->image
                            : null,
                        'specialization' => $comment->lawyer->profile->specialization ?? 'N/A',
                    ]
                ],
            ];
        });

        return response()->json([
            'status' => true,
            'data' => $commentsData,
        ]);
    }
}
