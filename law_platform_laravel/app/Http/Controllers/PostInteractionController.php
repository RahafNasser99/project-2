<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\PostInteraction;
use App\Notifications\InteractionNotification;
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

        // Send notification to the owner of the post
        if ($interaction->post->user) {
            $interaction->post->user->notify(new InteractionNotification($user, $interaction->post));
        }

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

        $interaction->user->notify(new InteractionNotification(Auth::user(), $interaction));

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
        $post = Post::with(['interactions.user'])->find($id); // Eager load the user for each interaction

        if (!$post) {
            return response()->json([
                'status' => false,
                'message' => 'Post not found'
            ], 404);
        }

        // Format the interactions data
        $interactionsData = $post->interactions->map(function ($interaction) {
            return [
                'id' => $interaction->id,
                'liked' => $interaction->liked,
                'disliked' => $interaction->disliked,
                'created_at' => $interaction->created_at,
                'user' => [
                    'id' => $interaction->user->id,
                    'name' => $interaction->user->name,
                    'email' => $interaction->user->email,
                    'account_type' => class_basename($interaction->user), // Member or Lawyer
                    'profile' => [
                        'specialization' => $interaction->user->profile->specialization ?? null,
                        'work' => $interaction->user->profile->work ?? null,
                        'image' => $interaction->user->profile->image ? '/storage/' . $interaction->user->profile->image : null,
                    ],
                ],
            ];
        });

        return response()->json([
            'status' => true,
            'data' => $interactionsData
        ]);
    }

    // Fetch only likes for a specific post
    public function getLikes($id)
    {
        $post = Post::with(['interactions' => function ($query) {
            $query->where('liked', true);
        }, 'interactions.user'])->find($id);

        if (!$post) {
            return response()->json([
                'status' => false,
                'message' => 'Post not found'
            ], 404);
        }

        $likesData = $post->interactions->map(function ($interaction) {
            return [
                'id' => $interaction->id,
                'liked' => $interaction->liked,
                'created_at' => $interaction->created_at,
                'user' => [
                    'id' => $interaction->user->id,
                    'name' => $interaction->user->name,
                    'email' => $interaction->user->email,
                    'account_type' => class_basename($interaction->user), // Member or Lawyer
                    'profile' => [
                        'specialization' => $interaction->user->profile->specialization ?? null,
                        'work' => $interaction->user->profile->work ?? null,
                        'image' => $interaction->user->profile->image ? '/storage/' . $interaction->user->profile->image : null,
                    ],
                ],
            ];
        });

        return response()->json([
            'status' => true,
            'data' => $likesData
        ]);
    }


    // Fetch only dislikes for a specific post
    public function getDislikes($id)
    {
        $post = Post::with(['interactions' => function ($query) {
            $query->where('disliked', true);
        }, 'interactions.user'])->find($id);

        if (!$post) {
            return response()->json([
                'status' => false,
                'message' => 'Post not found'
            ], 404);
        }

        $dislikesData = $post->interactions->map(function ($interaction) {
            return [
                'id' => $interaction->id,
                'disliked' => $interaction->disliked,
                'created_at' => $interaction->created_at,
                'user' => [
                    'id' => $interaction->user->id,
                    'name' => $interaction->user->name,
                    'email' => $interaction->user->email,
                    'account_type' => class_basename($interaction->user), // Member or Lawyer
                    'profile' => [
                        'specialization' => $interaction->user->profile->specialization ?? null,
                        'work' => $interaction->user->profile->work ?? null,
                        'image' => $interaction->user->profile->image ? '/storage/' . $interaction->user->profile->image : null,
                    ],
                ],
            ];
        });

        return response()->json([
            'status' => true,
            'data' => $dislikesData
        ]);
    }

}
