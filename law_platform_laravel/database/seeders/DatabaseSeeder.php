<?php

namespace Database\Seeders;

use App\Models\LegalAdvice;
use App\Models\User;
use App\Models\Member;
use App\Models\Lawyer;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();
        Member::factory(50)->create();
        Lawyer::factory(24)->create();
        LegalAdvice::factory(20)->create();

        $this->call([
            AdviceTypeSeeder::class,
            LegalAdviceSeeder::class,
            // Add other seeders here
        ]);

        // User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
