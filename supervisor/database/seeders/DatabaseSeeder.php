<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Create admin user
        User::factory()->create([
            'name' => 'Admin User',
            'role' => 'admin',
            'first_name' => 'Admin',
            'last_name' => 'User',
            'email' => 'admin@example.com',
            'phone_number' => '+92-300-1234567',
            'department' => 'Information Technology',
            'faculty' => 'Faculty of Computing',
        ]);

        // Create supervisors
        User::factory()->create([
            'name' => 'Dr. John Smith',
            'role' => 'supervisor',
            'first_name' => 'John',
            'last_name' => 'Smith',
            'email' => 'john.smith@example.com',
            'phone_number' => '+92-301-2345678',
            'department' => 'Computer Science',
            'faculty' => 'Faculty of Computing',
        ]);

        User::factory()->create([
            'name' => 'Dr. Sarah Johnson',
            'role' => 'supervisor',
            'first_name' => 'Sarah',
            'last_name' => 'Johnson',
            'email' => 'sarah.johnson@example.com',
            'phone_number' => '+92-302-3456789',
            'department' => 'Software Engineering',
            'faculty' => 'Faculty of Engineering',
        ]);

        User::factory()->create([
            'name' => 'Dr. Michael Brown',
            'role' => 'supervisor',
            'first_name' => 'Michael',
            'last_name' => 'Brown',
            'email' => 'michael.brown@example.com',
            'phone_number' => '+92-303-4567890',
            'department' => 'Data Science',
            'faculty' => 'Faculty of Science',
        ]);

        // Create students
        User::factory()->create([
            'name' => 'Alice Wilson',
            'role' => 'student',
            'first_name' => 'Alice',
            'last_name' => 'Wilson',
            'email' => 'alice.wilson@student.example.com',
            'phone_number' => '+92-304-5678901',
            'department' => 'Computer Science',
            'faculty' => 'Faculty of Computing',
        ]);

        User::factory()->create([
            'name' => 'Bob Davis',
            'role' => 'student',
            'first_name' => 'Bob',
            'last_name' => 'Davis',
            'email' => 'bob.davis@student.example.com',
            'phone_number' => '+92-305-6789012',
            'department' => 'Information Technology',
            'faculty' => 'Faculty of Computing',
        ]);

        User::factory()->create([
            'name' => 'Carol Garcia',
            'role' => 'student',
            'first_name' => 'Carol',
            'last_name' => 'Garcia',
            'email' => 'carol.garcia@student.example.com',
            'phone_number' => '+92-306-7890123',
            'department' => 'Software Engineering',
            'faculty' => 'Faculty of Engineering',
        ]);

        // Create additional random users using the factory
        User::factory(10)->create();
    }
}
