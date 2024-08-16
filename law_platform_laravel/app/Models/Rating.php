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

    // Define a polymorphic relationship to the user (could be either `Member` or `Lawyer`)
    public function user()
    {
        return $this->morphTo();
    }
}
