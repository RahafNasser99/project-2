<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use App\Models\Lawyer;

class LawyerProfile extends Model
{
    use HasFactory;

    protected $fillable = [
        'specialization',
        'biography',
        'image',
    ];

    public function lawyer(): HasOne
    {
        return $this->hasOne(Lawyer::class);
    }
}