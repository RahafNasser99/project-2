<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Laravel\Sanctum\HasApiTokens;
//use Illuminate\Database\Eloquent\Model;

class Lawyer extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function profile(): HasOne
    {
        return $this->hasOne(LawyerProfile::class);
    }

    public function posts(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Post::class);
    }

    public function interactions(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(PostInteraction::class, 'user_id');
    }

    public function comments(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(Comment::class, 'user');
    }

    // Relationship to ratings given by this member
    public function ratings()
    {
        return $this->morphMany(Rating::class, 'user');
    }

    public function calculateRating(): float
    {
        // Calculate the total likes and dislikes from all posts of the lawyer
        $totalLikes = 0;
        $totalDislikes = 0;

        foreach ($this->posts as $post) {
            $totalLikes += $post->likes_count;
            $totalDislikes += $post->dislikes_count;
        }

        // Handle edge case when there are no likes or dislikes
        if ($totalLikes + $totalDislikes === 0) {
            $r1 = 0;  // Avoid division by zero
        } else {
            // Calculate r1
            $r1 = ($totalLikes * 2.5) / ($totalLikes + $totalDislikes);
        }

        // Calculate r2 (direct ratings)
        $totalRatings = $this->ratings()->sum('rating');
        $ratingsCount = $this->ratings()->count();

        if ($ratingsCount === 0) {
            $r2 = 0;  // No direct ratings, avoid division by zero
        } else {
            $r2 = ($totalRatings * 2.5) / $ratingsCount;
        }

        // Final rating is the sum of r1 and r2
        $finalRating = $r1 + $r2;

        return round($finalRating, 2); // Round the result to 2 decimal places
    }

}
