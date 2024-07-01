<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LegalAdviceComment extends Model
{
    use HasFactory;

    protected $fillable = [
        'legal_advice_id',
        'lawyer_id',
        'comment',
    ];

    public function legalAdvice()
    {
        return $this->belongsTo(LegalAdvice::class);
    }

    public function lawyer()
    {
        return $this->belongsTo(Lawyer::class);
    }
}
