<?php

use App\Http\Controllers\CommentController;
use App\Http\Controllers\LawyerProfileController;
use App\Http\Controllers\LegalAdviceCommentController;
use App\Http\Controllers\LegalAdviceController;
use App\Http\Controllers\MemberProfileController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\PostInteractionController;
use App\Http\Controllers\UserSearchController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MemberAuthController;
use App\Http\Controllers\LawyerAuthController;
use App\Http\Controllers\RatingController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::prefix('member')->group(function () {
Route::post("register", [MemberAuthController::class, "register"]);
Route::post("login", [MemberAuthController::class, "login"]);

// Protected Routes
    Route::middleware(['auth:sanctum', 'checkMember'])->group(function () {

    Route::get("logout", [MemberAuthController::class, "logout"]);
    Route::get("refresh-token", [MemberAuthController::class, "refreshToken"]);
    Route::post('update', [MemberAuthController::class, 'update']);
    Route::post('nameUpdate', [MemberAuthController::class, 'nameUpdate']);
    Route::post('passwordUpdate', [MemberAuthController::class, 'passwordUpdate']);
    Route::delete('delete', [MemberAuthController::class, 'destroy']);
    Route::get('users', [MemberAuthController::class, 'viewAllUsers']);
    Route::get('users/{id}', [MemberAuthController::class, 'viewUser']);
    Route::get('lawyers', [MemberAuthController::class, 'viewAllLawyers']);
    Route::get('lawyers/{id}', [MemberAuthController::class, 'viewLawyer']);
    Route::get('viewProfile', [MemberProfileController::class, 'viewProfile']);
    Route::post('editProfile', [MemberProfileController::class, 'editProfile']);
    Route::get('member-profile/{id}', [MemberProfileController::class, 'viewMemberProfile']);
    Route::get('lawyer-profile/{id}', [MemberProfileController::class, 'viewLawyerProfile']);
    Route::get('my-legal-advices', [LegalAdviceController::class, 'getMyLegalAdvices']);
});
});

///////////////////////////////////////////////////////////////////////////////////////////
Route::prefix('lawyer')->group(function () {
Route::post("register", [LawyerAuthController::class, "register"]);
Route::post("login", [LawyerAuthController::class, "login"]);

// Protected Routes
    Route::middleware(['auth:sanctum', 'checkLawyer'])->group(function () {

    Route::get("logout", [LawyerAuthController::class, "logout"]);
    Route::get("refresh-token", [LawyerAuthController::class, "refreshToken"]);
    Route::post('update', [LawyerAuthController::class, 'update']);
    Route::post('nameUpdate', [LawyerAuthController::class, 'nameUpdate']);
    Route::post('passwordUpdate', [LawyerAuthController::class, 'passwordUpdate']);
    Route::delete('delete', [LawyerAuthController::class, 'destroy']);
    Route::get('users', [LawyerAuthController::class, 'viewAllUsers']);
    Route::get('users/{id}', [LawyerAuthController::class, 'viewUser']);
    Route::get('lawyers', [LawyerAuthController::class, 'viewAllLawyers']);
    Route::get('lawyers/{id}', [LawyerAuthController::class, 'viewLawyer']);
    Route::get('viewProfile', [LawyerProfileController::class, 'viewProfile']);
    Route::post('editProfile', [LawyerProfileController::class, 'editProfile']);
    Route::get('member-profile/{id}', [LawyerProfileController::class, 'viewMemberProfile']);
    Route::get('lawyer-profile/{id}', [LawyerProfileController::class, 'viewLawyerProfile']);
    Route::get('my-posts', [PostController::class, 'myPosts']);
});
});

///////////////////////////////////////////////////////////////////////////////////////////
Route::prefix('post')->group(function () {
// Protected Routes

    Route::middleware(['auth:sanctum','checkLawyer'])->group(function () {
    Route::post('create', [PostController::class, 'store']);
    Route::post('update/{id}', [PostController::class, 'update']);
    Route::delete('delete/{id}', [PostController::class, 'destroy']);
    });

    // Allow all authenticated users to view posts
    Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('all', [PostController::class, 'index']);
    Route::get('lawyers/{lawyerId}/posts', [PostController::class, 'getPostsByLawyer']);
    Route::get('viewAPost/{id}', [PostController::class, 'show']);
    Route::post('{id}/like', [PostInteractionController::class, 'like']);
    Route::post('{id}/unlike', [PostInteractionController::class, 'unlike']);
    Route::post('{id}/dislike', [PostInteractionController::class, 'dislike']);
    Route::post('{id}/undislike', [PostInteractionController::class, 'undislike']);
    Route::get('{id}/interactions', [PostInteractionController::class, 'getInteractions']);
    Route::get('{id}/getLikes', [PostInteractionController::class, 'getLikes']);
    Route::get('{id}/getDislikes', [PostInteractionController::class, 'getDislikes']);
    Route::get('{postId}/allComments', [CommentController::class, 'index']);
    Route::post('{postId}/createComment', [CommentController::class, 'store']);
    Route::post('updateComment/{commentId}', [CommentController::class, 'update']);
    Route::delete('deleteComment/{commentId}', [CommentController::class, 'destroy']);
    });
});

/////////////////////////////////////////////////////////////////////////////////////////////
Route::prefix('legalAdvice')->group(function () {
// Protected Routes

    Route::middleware(['auth:sanctum', 'checkMember'])->group(function () {
    Route::post('create', [LegalAdviceController::class, 'store']);
    Route::post('update/{id}', [LegalAdviceController::class, 'update']);
    Route::delete('delete/{id}', [LegalAdviceController::class, 'destroy']);
    });

    Route::middleware(['auth:sanctum', 'checkLawyer'])->group(function () {
    Route::post('{legalAdviceId}/createComment', [LegalAdviceCommentController::class, 'store']);
    Route::post('updateComment/{id}', [LegalAdviceCommentController::class, 'update']);
    Route::delete('deleteComment/{id}', [LegalAdviceCommentController::class, 'destroy']);
    });

    // Allow all authenticated users to view legal advices
    Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('all', [LegalAdviceController::class, 'index']);
    Route::get('members/{memberId}/legal-advices', [LegalAdviceController::class, 'getLegalAdvicesByMember']);
    Route::get('viewAnAdvice/{id}', [LegalAdviceController::class, 'show']);
    Route::get('adviceTypes/{adviceTypeId}', [LegalAdviceController::class, 'getByAdviceType']);
    Route::get('{legalAdviceId}/allComments', [LegalAdviceCommentController::class, 'index']);
    });
});

//////////////////////////////////////////////////////////////////////////////////////////////////////

// Route for searching users
//Route::middleware(['auth:sanctum'])->get('search/users', [UserSearchController::class, 'search']);




Route::middleware(['auth:sanctum'])->group(function () {

    Route::get('search/users', [UserSearchController::class, 'search']);

    // Submit a rating for a lawyer
    Route::post('lawyers/{lawyerId}/rate', [RatingController::class, 'rateLawyer']);

    // Get the final rating of a lawyer
    Route::get('lawyers/{lawyerId}/Getrating', [RatingController::class, 'getLawyerRating']);

    //Route::get('getNotifications', [NotificationController::class, 'getNotifications']);
});

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/notifications', [NotificationController::class, 'getNotifications']);
    Route::post('/notifications/{id}/read', [NotificationController::class, 'markAsRead']);
    Route::post('/notifications/read-all', [NotificationController::class, 'markAllAsRead']);
});

