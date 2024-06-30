<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LegalAdvice extends Model
{
    use HasFactory;

    protected $fillable = [
        'member_id',
        'advice_type_id',
        'text',
        'image',
        'date',
    ];

    protected $table = 'legal_advices'; // Ensure the table name is correct

    public function member(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Member::class);
    }

    public function adviceType(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(AdviceType::class);
    }

    public function comments(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(LegalAdviceComment::class);
    }

    public function getCommentsCountAttribute()
    {
        return $this->comments()->count();
    }

    // Automatically set the 'date' attribute to the current timestamp when creating or updating
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->date = now();
        });

        static::updating(function ($model) {
            $model->date = now();
        });
    }
}
