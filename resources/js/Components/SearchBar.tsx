import React from "react";

interface SearchBarProps {
    placeholder?: string;
    onSearch?: (query: string) => void;
}

export default function SearchBar({
    placeholder = "Search...",
    onSearch,
}: SearchBarProps) {
    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        if (onSearch) {
            onSearch(e.target.value);
        }
    };

    return (
        <input
            type="text"
            placeholder={placeholder}
            onChange={handleChange}
            className="w-64 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
        />
    );
}
