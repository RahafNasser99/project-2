<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('legal_advice_comments', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('legal_advice_id');
            $table->unsignedBigInteger('lawyer_id');
            $table->text('comment');
            $table->timestamps();

            $table->foreign('legal_advice_id')->references('id')->on('legal_advices')->onDelete('cascade');
            $table->foreign('lawyer_id')->references('id')->on('lawyers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('legal_advice_comments');
    }
};
