<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\Post;
use App\Notifications\CommentNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    // Get all comments for a post
    public function index($postId)
    {
        $post = Post::findOrFail($postId);
        //$comments = $post->comments;
        // Load comments along with the user who made each comment
        $comments = $post->comments()->with('user.profile')->get();

        // Format the response to include the commenter information
        $commentsData = $comments->map(function ($comment) {
            // Determine if the user is a Lawyer or a Member
            $accountType = class_basename($comment->user);
            return [
                'id' => $comment->id,
                'content' => $comment->content,
                'created_at' => $comment->created_at,
                'updated_at' => $comment->updated_at,
                'user' => [
                    'id' => $comment->user->id,
                    'name' => $comment->user->name,
                    'email' => $comment->user->email,
                    'account_type' => class_basename($comment->user), // Member or Lawyer
                    'profile' => [
                        'specialization' => $accountType === 'Lawyer'
                            ? $comment->user->profile->specialization ?? 'N/A'
                            : null,
                        'work' => $accountType === 'Member'
                            ? $comment->user->profile->work ?? 'N/A'
                            : null,
                        'image' => $comment->user->profile->image
                        ? '/storage/' . $comment->user->profile->image
                        : null,
                        ]
                ],
            ];
        });

        return response()->json([
            'status' => true,
            'data' => $commentsData,
        ]);
    }

    // Add a comment to a post
    public function store(Request $request, $postId)
    {
        $request->validate([
            'content' => 'required|string',
        ]);

        $post = Post::findOrFail($postId);
        $user = Auth::user();

        $comment = Comment::create([
            'post_id' => $post->id,
            'user_id' => $user->id,
            'user_type' => get_class($user),
            'content' => $request->input('content'),
        ]);

        // Send notification to the owner of the post
        if ($post->user) {
            $post->user->notify(new CommentNotification(Auth::user(), $post));
        }

        return response()->json([
            'status' => true,
            'message' => 'Comment added successfully',
            'data' => $comment
        ]);
    }

    // Update a comment
    public function update(Request $request, $commentId)
    {
        $comment = Comment::findOrFail($commentId);

        // Check if the authenticated user is the owner of the comment
        if ($comment->user_id !== Auth::id() || get_class(Auth::user()) !== $comment->user_type) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized'
            ], 403);
        }

        $request->validate([
            'content' => 'required|string',
        ]);

        $comment->update([
            'content' => $request->input('content'),
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Comment updated successfully',
            'data' => $comment
        ]);
    }

    // Delete a comment
    public function destroy($commentId)
    {
        $comment = Comment::findOrFail($commentId);

        // Check if the authenticated user is the owner of the comment
        if ($comment->user_id !== Auth::id() || get_class(Auth::user()) !== $comment->user_type) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized'
            ], 403);
        }

        $comment->delete();

        return response()->json([
            'status' => true,
            'message' => 'Comment deleted successfully'
        ]);
    }
}
