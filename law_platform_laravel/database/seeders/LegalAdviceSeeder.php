<?php

namespace Database\Seeders;

use App\Models\AdviceType;
use App\Models\LegalAdvice;
use App\Models\Member;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class LegalAdviceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
//        $member = Member::first(); // Assuming you have members in your database
//        $adviceTypes = AdviceType::all(); // Assuming you have advice types in your database

        $legalAdvices = [
            [
                'member_id' => 33,
                'advice_type_id' => 1,
                'text' => 'This is legal advice on Animal law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 22,
                'advice_type_id' => 1,
                'text' => 'This is anther legal advice on Animal law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 11,
                'advice_type_id' => 2,
                'text' => 'This is legal advice on Admiralty law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 44,
                'advice_type_id' => 3,
                'text' => 'This is legal advice on Bankruptcy law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 33,
                'advice_type_id' => 4,
                'text' => 'This is legal advice on Banking and Finance law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 100,
                'advice_type_id' => 3,
                'text' => 'This is another legal advice on Bankruptcy law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 99,
                'advice_type_id' => 3,
                'text' => 'This is once more one of legal advice on Bankruptcy law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 88,
                'advice_type_id' => 12,
                'text' => 'This is legal advice on Family law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 77,
                'advice_type_id' => 9,
                'text' => 'This is legal advice on Criminal law.',
                'image' => null,
                'date' => now(),
            ],
            [
                'member_id' => 66,
                'advice_type_id' => 3,
                'text' => 'This is legal advice on Bankruptcy law.',
                'image' => null,
                'date' => now(),
            ],
        ];

        foreach ($legalAdvices as $advice) {
            LegalAdvice::create($advice);
        }
    }
}
