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
        'lawyer_id',
        'specialization',
        'biography',
        'image',
    ];

    public function lawyer(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Lawyer::class);
    }
}
