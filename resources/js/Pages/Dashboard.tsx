import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout";
import { Head } from "@inertiajs/react";
import SearchBar from "@/Components/SearchBar";

export default function Dashboard() {
    return (
        <div className="flex h-screen">
            {/* Sidebar - light grey */}
            <div className="w-64 bg-gray-200 p-4"></div>

            {/* Main content area with search bar */}
            <div className="flex-1 flex flex-col bg-white">
                {/* Search bar container */}
                <div className="p-4 border-b border-gray-200 bg-gray-50">
                    <SearchBar />
                </div>

                {/* Scrollable dashboard content */}
                <div className="flex-1 p-6 overflow-auto">
                    <h1 className="text-2xl font-bold mb-1">My Dashboard</h1>
                    <p className="mb-6">Track your thesis progression and submission</p>
                    {/* Add your cards, charts, tables, etc. */}
                    {/* Two‑column layout – right column height independent */}
                    <div className="flex flex-col md:flex-row gap-6 items-start">
                        {/* Left / left main content */}
                        <div className="md:w-2/3 space-y-6">
                            {/* current submission div */}
                            <div className="bg-white border rounded-lg shadow-sm p-4">
                                
                            </div>

                            {/* my documents div */}
                            <div className="bg-white border rounded-lg shadow-sm p-4">
                                
                            </div>
                            {/* my documents div */}
                            <div className="bg-white border rounded-lg shadow-sm p-4">
                                
                            </div>
                            {/* Feedback div */}
                            <div className="bg-white border rounded-lg shadow-sm p-4">
                               
                            </div>
                        </div>

                        {/* submission progress div */}
                        <div className="md:w-1/3 bg-gray-50 border rounded-lg shadow-sm p-4">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
