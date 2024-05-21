<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MemberAuthController;
use App\Http\Controllers\LawyerAuthController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::prefix('member')->group(function () {
Route::post("register", [MemberAuthController::class, "register"]);
Route::post("login", [MemberAuthController::class, "login"]);

// Protected Routes
Route::group([
    "middleware" => ["auth:sanctum"]
], function(){

    //Route::get("profile", [MemberAuthController::class, "profile"]);
    Route::get("logout", [MemberAuthController::class, "logout"]);
    Route::get("refresh-token", [MemberAuthController::class, "refreshToken"]);
});
});

///////////////////////////////////////////////////////////////////////////////////////////
Route::prefix('lawyer')->group(function () {
Route::post("register", [LawyerAuthController::class, "register"]);
Route::post("login", [LawyerAuthController::class, "login"]);

// Protected Routes
Route::group([
    "middleware" => ["auth:sanctum"]
], function(){

    //Route::get("profile", [LawyerAuthController::class, "profile"]);
    Route::get("logout", [LawyerAuthController::class, "logout"]);
    Route::get("refresh-token", [LawyerAuthController::class, "refreshToken"]);
});
});