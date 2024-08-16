<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rating extends Model
{
    // Allow mass assignment for these attributes
    protected $fillable = [
        'lawyer_id',
        'user_id',
        'user_type',
        'rating',
    ];

    // Define the relationship to the `Lawyer` model
    public function lawyer()
    {
        return $this->belongsTo(Lawyer::class);
    }

<<<<<<< HEAD
    public function member()
    {
        return $this->belongsTo(Member::class);
    }

    // Define a polymorphic relationship to the user (could be either `Member` or `Lawyer`)
    public function user(): \Illuminate\Database\Eloquent\Relations\MorphTo
    {
        return $this->morphTo();
    }

    public function rateable(): \Illuminate\Database\Eloquent\Relations\MorphTo
=======
    // Define a polymorphic relationship to the user (could be either `Member` or `Lawyer`)
    public function user()
>>>>>>> fbc098416843d9e6016a791f9a5948cdbbea3787
    {
        return $this->morphTo();
    }
}
