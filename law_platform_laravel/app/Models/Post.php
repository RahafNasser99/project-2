<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Post extends Model
{
    use HasFactory;

    protected $fillable = [
        'lawyer_id',
        'text',
        'image',
        'date',
    ];

    public function lawyer(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Lawyer::class);
    }

    public function interactions(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(PostInteraction::class);
    }

    public function userInteraction($userId, $userType): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(PostInteraction::class)
            ->where('user_id', $userId)
            ->where('user_type', $userType);
    }

    public function comments(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Comment::class);
    }

    public function getLikesCountAttribute()
    {
        return $this->interactions()->where('liked', true)->count();
    }

    public function getDislikesCountAttribute()
    {
        return $this->interactions()->where('disliked', true)->count();
    }

    public function getCommentsCountAttribute()
    {
        return $this->comments()->count();
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($post) {
            $post->date = Carbon::now()->toDateString();
        });

        static::updating(function ($post) {
            $post->date = Carbon::now()->toDateString();
        });
    }
}
