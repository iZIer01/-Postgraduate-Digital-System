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
        $sql = File::get(database_path('schema.sql'));
        DB::unprepared($sql);

        // Schema::create('tables_from_sql', function (Blueprint $table) {
        //     $table->id();
        //     $table->timestamps();
        // });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Optional: Add logic to drop the tables if you need to rollback
        //Schema::dropIfExists('tables_from_sql');
    }
};




