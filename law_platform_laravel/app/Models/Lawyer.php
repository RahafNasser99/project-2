<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Container\Container;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Laravel\Sanctum\HasApiTokens;
//use Illuminate\Database\Eloquent\Model;
use App\Models\Member;

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
<<<<<<< HEAD
//    public function ratings(): \Illuminate\Database\Eloquent\Relations\MorphMany
//    {
//        return $this->morphMany(Rating::class, 'user');
//    }

    public function ratings(): \Illuminate\Database\Eloquent\Relations\MorphMany
=======
    public function ratings()
>>>>>>> fbc098416843d9e6016a791f9a5948cdbbea3787
    {
        return $this->morphMany(Rating::class, 'user');
    }

<<<<<<< HEAD
//    function app($abstract = null, array $parameters = [])
//    {
//        if (is_null($abstract)) {
//            return Container::getInstance();
//        }
//
//        return Container::getInstance()->make($abstract, $parameters);
//    }
//    public function calculateRating(): float
//    {
//        // Calculate the total likes and dislikes from all posts of the lawyer
//        $totalLikes = 0;
//        $totalDislikes = 0;
//
//        foreach ($this->posts as $post) {
//            $totalLikes += $post->likes_count;
//            $totalDislikes += $post->dislikes_count;
//        }
//
//        // Handle edge case when there are no likes or dislikes
//        if ($totalLikes + $totalDislikes === 0) {
//            $r1 = 0;  // Avoid division by zero
//        } else {
//            // Calculate r1
//            $r1 = ($totalLikes * 2.5) / ($totalLikes + $totalDislikes);
//        }
//
//        // Calculate r2 (direct ratings)
//        $totalRatings = $this->ratings()->sum('rating');
//        $ratingsCount = $this->ratings()->count();
//
//        if ($ratingsCount === 0) {
//            $r2 = 0;  // No direct ratings, avoid division by zero
//        } else {
//            $r2 = ($totalRatings * 2.5) / $ratingsCount;
//        }
//
//        // Final rating is the sum of r1 and r2
//        $finalRating = $r1 + $r2;
//
//        return round($finalRating, 2); // Round the result to 2 decimal places
//    }

//    public function calculateRating(): float
//    {
//        // Calculate the total likes and dislikes from all posts of the lawyer
//        $totalLikes = 0;
//        $totalDislikes = 0;
//
//        foreach ($this->posts as $post) {
//            $totalLikes += $post->likes_count;
//            $totalDislikes += $post->dislikes_count;
//        }
//
//        $r1 = ($totalLikes + $totalDislikes > 0)
//            ? ($totalLikes * 2.5) / ($totalLikes + $totalDislikes)
//            : 0;
//
//        // Calculate r2 (direct ratings)
//        $lawyerRatingsSum = $this->ratings()->where('user_type', Lawyer::class)->sum('rating');
//        $lawyerRatingsCount = $this->ratings()->where('user_type', Lawyer::class)->count();
//
//        $memberRatingsSum = $this->ratings()->where('user_type', Member::class)->sum('rating');
//        $memberRatingsCount = $this->ratings()->where('user_type', Member::class)->count();
//
//        // Weighting factors
//        $lawyerWeight = 0.7;  // Weight for lawyer ratings
//        $memberWeight = 0.3;  // Weight for member ratings
//
//        $lawyerAverageRating = $lawyerRatingsCount > 0
//            ? ($lawyerRatingsSum / $lawyerRatingsCount) * 2.5
//            : 0;
//
//        $memberAverageRating = $memberRatingsCount > 0
//            ? ($memberRatingsSum / $memberRatingsCount) * 2.5
//            : 0;
//
//        // Calculate weighted r2
//        $r2 = ($lawyerAverageRating * $lawyerWeight) + ($memberAverageRating * $memberWeight);
//
//        // Final rating
//        $finalRating = $r1 + $r2;
//
//        return round($finalRating, 2); // Round the result to 2 decimal places
//    }

    public function calculateRating(): float
    {
        // Separate ratings from lawyers and members
        $lawyerRatingsSum = $this->ratings()->where('user_type', Lawyer::class)->sum('rating');
        $lawyerRatingsCount = $this->ratings()->where('user_type', Lawyer::class)->count();

        $memberRatingsSum = $this->ratings()->where('user_type', Member::class)->sum('rating');
        $memberRatingsCount = $this->ratings()->where('user_type', Member::class)->count();

        // Handle cases where there are no ratings
        if ($lawyerRatingsCount === 0 && $memberRatingsCount === 0) {
            return 0.0;  // No ratings at all
        }

        // Weighting factors
        $lawyerWeight = 0.7;  // Weight for lawyer ratings
        $memberWeight = 0.3;  // Weight for member ratings

        // Calculate weighted averages
        $lawyerAverageRating = $lawyerRatingsCount > 0
            ? $lawyerRatingsSum / $lawyerRatingsCount
            : 0;

        $memberAverageRating = $memberRatingsCount > 0
            ? $memberRatingsSum / $memberRatingsCount
            : 0;

        // Calculate weighted final rating
        $finalRating = ($lawyerAverageRating * $lawyerWeight) + ($memberAverageRating * $memberWeight);
=======
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
>>>>>>> fbc098416843d9e6016a791f9a5948cdbbea3787

        return round($finalRating, 2); // Round the result to 2 decimal places
    }

<<<<<<< HEAD
//    public function calculateRating(): float
//    {
//        // Get ratings for the lawyer grouped by user type (lawyer and member)
//        $lawyerRatingsSum = $this->ratings()->where('user_type', Lawyer::class)->sum('rating');
//        $lawyerRatingsCount = $this->ratings()->where('user_type', Lawyer::class)->count();
//
//        $memberRatingsSum = $this->app('App\Models\Member')->memratings()->where('user_type', Member::class)->sum('rating');
//        $memberRatingsCount = $this->app('App\Models\Member')->memratings()->where('user_type', Member::class)->count();
//
//        // Handle cases where there are no ratings
//        if ($lawyerRatingsCount === 0 && $memberRatingsCount === 0) {
//            return 0.0;  // No ratings at all
//        }
//
//        // Calculate averages only if there are ratings for that user type
//        $lawyerAverageRating = $lawyerRatingsCount > 0 ? $lawyerRatingsSum / $lawyerRatingsCount : 0;
//        $memberAverageRating = $memberRatingsCount > 0 ? $memberRatingsSum / $memberRatingsCount : 0;
//
//        // Weighting factors
//        $lawyerWeight = 0.7;  // Weight for lawyer ratings
//        $memberWeight = 0.3;  // Weight for member ratings
//
//        // If there are no ratings from a particular group, its weight will be 0
//        $lawyerContribution = $lawyerRatingsCount > 0 ? $lawyerAverageRating * $lawyerWeight : 0;
//        $memberContribution = $memberRatingsCount > 0 ? $memberAverageRating * $memberWeight : 0;
//
//        // Sum contributions from both groups
//        $finalRating = $lawyerContribution + $memberContribution;
//
//        return round($finalRating, 2); // Round the result to 2 decimal places
//    }

//    public function calculateRating(): float
//    {
//        // Retrieve ratings from both lawyers and members
//        $lawyerRatingsSum = $this->lawRatings()->where('user_type', Lawyer::class)->sum('rating');
//        $lawyerRatingsCount = $this->lawRatings()->where('user_type', Lawyer::class)->count();
//
//        $memberRatingsSum = $this->memRatings()->where('user_type', Member::class)->sum('rating');
//        $memberRatingsCount = $this->memRatings()->where('user_type', Member::class)->count();
//
//        // Check if there are no ratings at all
//        if ($lawyerRatingsCount + $memberRatingsCount === 0) {
//            return 0.0;  // No ratings
//        }
//
//        // Calculate averages only if there are ratings
//        $lawyerAverageRating = $lawyerRatingsCount > 0 ? $lawyerRatingsSum / $lawyerRatingsCount : 0;
//        $memberAverageRating = $memberRatingsCount > 0 ? $memberRatingsSum / $memberRatingsCount : 0;
//
//        // Define weighting factors
//        $lawyerWeight = 0.7;  // Higher weight for lawyer ratings
//        $memberWeight = 0.3;  // Lower weight for member ratings
//
//        // Calculate weighted contributions
//        $lawyerContribution = $lawyerRatingsCount > 0 ? $lawyerAverageRating * $lawyerWeight : 0;
//        $memberContribution = $memberRatingsCount > 0 ? $memberAverageRating * $memberWeight : 0;
//
//        // Sum the weighted contributions to get the final rating
//        $finalRating = $lawyerContribution + $memberContribution;
//
//        // Round the final rating to two decimal places
//        return round($finalRating, 2);
//    }

//    public function calculateRating(): float
//    {
//        // Retrieve all ratings for this lawyer
//        $ratings = $this->ratings;
//
//        // Separate lawyer and member ratings
//        $lawyerRatingsSum = $ratings->where('user_type', Lawyer::class)->sum('rating');
//        $lawyerRatingsCount = $ratings->where('user_type', Lawyer::class)->count();
//
//        $memberRatingsSum = $ratings->where('user_type', Member::class)->sum('rating');
//        $memberRatingsCount = $ratings->where('user_type', Member::class)->count();
//
//        // Check if there are no ratings at all
//        if ($lawyerRatingsCount + $memberRatingsCount === 0) {
//            return 0.0;  // No ratings
//        }
//
//        // Calculate averages only if there are ratings
//        $lawyerAverageRating = $lawyerRatingsCount > 0 ? $lawyerRatingsSum / $lawyerRatingsCount : 0;
//        $memberAverageRating = $memberRatingsCount > 0 ? $memberRatingsSum / $memberRatingsCount : 0;
//
//        // Define weighting factors
//        $lawyerWeight = 0.7;  // Higher weight for lawyer ratings
//        $memberWeight = 0.3;  // Lower weight for member ratings
//
//        // Calculate weighted contributions
//        $lawyerContribution = $lawyerAverageRating * $lawyerWeight;
//        $memberContribution = $memberAverageRating * $memberWeight;
//
//        // Sum the weighted contributions to get the final rating
//        $finalRating = $lawyerContribution + $memberContribution;
//
//        // Round the final rating to two decimal places
//        return round($finalRating, 2);
//    }


//    public function calculateRating(): float
//    {
//        // Retrieve all ratings for this lawyer
//        $ratings = $this->ratings();
//        app('App\Member')->ratings();
////        if ($ratings->isEmpty()) {
////            return 0.0;  // No ratings
////        }
//
//        // Separate lawyer and member ratings
//        $lawyerRatings = $ratings->where('user_type', Lawyer::class);
//        $memberRatings = $ratings->where('user_type', Member::class);
//
//        // Calculate the sums and counts
//        $lawyerRatingsSum = $lawyerRatings->sum('rating');
//        $lawyerRatingsCount = $lawyerRatings->count();
//
//        $memberRatingsSum = $memberRatings->sum('rating');
//        $memberRatingsCount = $memberRatings->count();
//
//        // Calculate averages only if there are ratings
//        $lawyerAverageRating = $lawyerRatingsCount > 0 ? $lawyerRatingsSum / $lawyerRatingsCount : 0;
//        $memberAverageRating = $memberRatingsCount > 0 ? $memberRatingsSum / $memberRatingsCount : 0;
//
//        // Define weighting factors
//        $lawyerWeight = 0.7;  // Higher weight for lawyer ratings
//        $memberWeight = 0.3;  // Lower weight for member ratings
//
//        // Calculate weighted contributions
//        $lawyerContribution = $lawyerAverageRating * $lawyerWeight;
//        $memberContribution = $memberAverageRating * $memberWeight;
//
//        // Sum the weighted contributions to get the final rating
//        $finalRating = $lawyerContribution + $memberContribution;
//
//        // Round the final rating to two decimal places
//        return round($finalRating, 2);
//    }


=======
>>>>>>> fbc098416843d9e6016a791f9a5948cdbbea3787
}
