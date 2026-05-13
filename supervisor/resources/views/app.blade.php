<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title inertia>{{ config('app.name', 'Laravel') }}</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

        <!-- Scripts -->
        @routes
        @viteReactRefresh
        @php
            $component = $page['component'] ?? null;
            $pageScript = null;

            if ($component) {
                $jsxPath = resource_path("js/Pages/{$component}.jsx");
                $tsxPath = resource_path("js/Pages/{$component}.tsx");

                if (file_exists($jsxPath)) {
                    $pageScript = "resources/js/Pages/{$component}.jsx";
                } elseif (file_exists($tsxPath)) {
                    $pageScript = "resources/js/Pages/{$component}.tsx";
                }
            }
        @endphp
        @vite(array_filter(['resources/js/app.tsx', $pageScript]))
        @inertiaHead
    </head>
    <body class="font-sans antialiased">
        @inertia
    </body>
</html>
