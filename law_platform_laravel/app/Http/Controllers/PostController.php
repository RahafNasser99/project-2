<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PostController extends Controller
{
    // Get all posts with pagination
    public function index(Request $request)
    {
        $user = Auth::user();

        // Get the number of posts per page from the query parameter, default to 10 if not provided
        $perPage = $request->query('per_page', 10);

        // Paginate the posts
        $posts = Post::paginate($perPage);

        // Map through the paginated posts to include interaction data
        $postsData = $posts->map(function ($post) use ($user) {
            $interaction = $post->userInteraction($user->id, get_class($user))->first();
            return [
                'id' => $post->id,
                'lawyer_id' => $post->lawyer_id,
                'text' => $post->text,
                'image' => $post->image,
                'date' => $post->date,
                'likes_count' => $post->likes_count,
                'dislikes_count' => $post->dislikes_count,
                'comments_count' => $post->comments_count,
                'user_interaction' => [
                    'liked' => $interaction ? $interaction->liked : false,
                    'disliked' => $interaction ? $interaction->disliked : false,
                ]
            ];
        });

        // Include pagination information in the response
        return response()->json([
            'status' => true,
            'data' => $postsData,
            'pagination' => [
                'current_page' => $posts->currentPage(),
                'per_page' => $posts->perPage(),
                'total_pages' => $posts->lastPage(),
                'total_posts' => $posts->total(),
            ]
        ]);
    }

    // Create a new post (POST - text, image, date)
    public function store(Request $request)
    {
        $request->validate([
            'text' => 'required|string',
            'image' => 'nullable|image|max:2048',
        ]);

        $imagePath = $request->hasFile('image') ? $request->file('image')->store('post_images', 'public') : null;

        $post = Post::create([
            'lawyer_id' => Auth::id(),
            'text' => $request->text,
            'image' => $imagePath,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Post created successfully',
            'data' => $post
        ]);
    }

    // Get a specific post by ID
    public function show($id)
    {
        $post = Post::find($id);

        if (!$post) {
            return response()->json([
                'status' => false,
                'message' => 'Post not found'
            ], 404);
        }

        $user = Auth::user();
        $interaction = $post->userInteraction($user->id, get_class($user))->first();

        return response()->json([
            'status' => true,
            'data' => [
                'id' => $post->id,
                'lawyer_id' => $post->lawyer_id,
                'text' => $post->text,
                'image' => $post->image,
                'date' => $post->date,
                'likes_count' => $post->likes_count,
                'dislikes_count' => $post->dislikes_count,
                'comments_count' => $post->comments_count,
                'user_interaction' => [
                    'liked' => $interaction ? $interaction->liked : false,
                    'disliked' => $interaction ? $interaction->disliked : false,
                ]
            ]
        ]);
    }

    // Update a post (PUT - text, image, date)
    public function update(Request $request, $id)
    {
        $post = Post::find($id);

        if (!$post) {
            return response()->json([
                'status' => false,
                'message' => 'Post not found'
            ], 404);
        }

        // Check if the authenticated user is the owner of the post
        if ($post->lawyer_id !== Auth::id()) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized'
            ], 403);
        }

        $request->validate([
            'text' => 'required|string',
            'image' => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('post_images', 'public');
        }

        $post->update([
            'text' => $request->text,
            'image' => $request->hasFile('image') ? $imagePath : $post->image,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Post updated successfully',
            'data' => $post
        ]);
    }

    // Delete a post
    public function destroy($id)
    {
        $post = Post::find($id);

        if (!$post) {
            return response()->json([
                'status' => false,
                'message' => 'Post not found'
            ], 404);
        }

        // Check if the authenticated user is the owner of the post
        if ($post->lawyer_id !== Auth::id()) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized'
            ], 403);
        }

        $post->delete();

        return response()->json([
            'status' => true,
            'message' => 'Post deleted successfully'
        ]);
    }
}
