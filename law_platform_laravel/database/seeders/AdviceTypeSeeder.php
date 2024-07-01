<?php

namespace Database\Seeders;

use App\Models\AdviceType;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AdviceTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $adviceTypes = [
            ['name' => 'Animal Law'],
            ['name' => 'Admiralty Law'],
            ['name' => 'Bankruptcy Law'],
            ['name' => 'Banking and Finance Law'],
            ['name' => 'Constitutional Law'],
            ['name' => 'Statutory Law'],
            ['name' => 'Common or Case Law'],
            ['name' => 'Civil Law'],
            ['name' => 'Criminal Law'],
            ['name' => 'Equity Law'],
            ['name' => 'Administrative Law'],
            ['name' => 'Family Law'],
            ['name' => 'Employment Law'],
            ['name' => 'International Law'],
            ['name' => 'Intellectual Property Law']
        ];

        foreach ($adviceTypes as $type) {
            AdviceType::create($type);
        }
    }
}
