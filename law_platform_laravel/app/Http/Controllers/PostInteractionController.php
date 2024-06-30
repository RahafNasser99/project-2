<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\PostInteraction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PostInteractionController extends Controller
{
    // Like a post
    public function like($id)
    {
        $user = Auth::user();
        $interaction = PostInteraction::firstOrNew([
            'post_id' => $id,
            'user_id' => $user->id,
            'user_type' => get_class($user),
        ]);

        $interaction->liked = true;
        $interaction->disliked = false;
        $interaction->save();

        return response()->json([
            'status' => true,
            'message' => 'Post liked successfully',
        ]);
    }

    // Unlike a post
    public function unlike($id)
    {
        $user = Auth::user();
        $interaction = PostInteraction::where([
            'post_id' => $id,
            'user_id' => $user->id,
            'user_type' => get_class($user),
        ])->first();

        if ($interaction) {
            $interaction->liked = false;
            $interaction->save();
        }

        return response()->json([
            'status' => true,
            'message' => 'Post unliked successfully',
        ]);
    }

    // Dislike a post
    public function dislike($id)
    {
        $user = Auth::user();
        $interaction = PostInteraction::firstOrNew([
            'post_id' => $id,
            'user_id' => $user->id,
            'user_type' => get_class($user),
        ]);

        $interaction->liked = false;
        $interaction->disliked = true;
        $interaction->save();

        return response()->json([
            'status' => true,
            'message' => 'Post disliked successfully',
        ]);
    }

    // Undislike a post
    public function undislike($id)
    {
        $user = Auth::user();
        $interaction = PostInteraction::where([
            'post_id' => $id,
            'user_id' => $user->id,
            'user_type' => get_class($user),
        ])->first();

        if ($interaction) {
            $interaction->disliked = false;
            $interaction->save();
        }

        return response()->json([
            'status' => true,
            'message' => 'Post undisliked successfully',
        ]);
    }

    // Fetch interactions for a specific post
    public function getInteractions($id)
    {
        $post = Post::with(['interactions'])->find($id);

        if (!$post) {
            return response()->json([
                'status' => false,
                'message' => 'Post not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'data' => $post->interactions
        ]);
    }
}
