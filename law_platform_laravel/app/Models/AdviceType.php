<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AdviceType extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
    ];

    public function legalAdvices(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(LegalAdvice::class);
    }
}
