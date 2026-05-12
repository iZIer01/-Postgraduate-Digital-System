<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * @extends Factory<User>
 */
class UserFactory extends Factory
{
    /**
     * The current password being used by the factory.
     */
    protected static ?string $password;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $firstName = fake()->firstName();
        $lastName = fake()->lastName();
        $roles = ['student', 'supervisor', 'admin'];
        $departments = ['Computer Science', 'Information Technology', 'Software Engineering', 'Data Science', 'Cybersecurity'];
        $faculties = ['Faculty of Computing', 'Faculty of Engineering', 'Faculty of Science'];

        return [
            'id' => Str::uuid(),
            'name' => $firstName . ' ' . $lastName,
            'role' => fake()->randomElement($roles),
            'first_name' => $firstName,
            'last_name' => $lastName,
            'email' => fake()->unique()->safeEmail(),
            'phone_number' => fake()->phoneNumber(),
            'department' => fake()->randomElement($departments),
            'faculty' => fake()->randomElement($faculties),
            'email_verified_at' => now(),
            'password' => static::$password ??= Hash::make('password'),
            'remember_token' => Str::random(10),
        ];
    }

    /**
     * Indicate that the model's email address should be unverified.
     */
    public function unverified(): static
    {
        return $this->state(fn (array $attributes) => [
            'email_verified_at' => null,
        ]);
    }
}
