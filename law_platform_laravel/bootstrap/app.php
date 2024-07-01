<?php

use App\Http\Middleware\CheckLawyer;
use App\Http\Middleware\CheckMember;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->web(append: [
            //
        ]);

        $middleware->api(append: [
//            'checkLawyer' => CheckLawyer::class,
//            'checkMember' => CheckMember::class,
        ]);

//        $middleware->append(CheckLawyer::class);
//        $middleware->append(CheckMember::class);

        $middleware->alias([
            'checkLawyer' => App\Http\Middleware\CheckLawyer::class,
            'checkMember' => App\Http\Middleware\CheckMember::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
