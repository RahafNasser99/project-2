<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use App\Models\Member;

class MemberProfile extends Model
{
    use HasFactory;

    protected $fillable = [
        'work',
        'biography',
        'image',
    ];

    public function member(): HasOne
    {
        return $this->hasOne(Member::class);
    }
}