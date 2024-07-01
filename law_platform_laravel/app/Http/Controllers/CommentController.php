<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    // Get all comments for a post
    public function index($postId)
    {
        $post = Post::findOrFail($postId);
        $comments = $post->comments;

        return response()->json([
            'status' => true,
            'data' => $comments
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
