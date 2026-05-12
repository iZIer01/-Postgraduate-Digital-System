/// <reference types="vite/client" />

// Global type declarations for the application
declare global {
  // Extend Window interface to include axios
  interface Window {
    axios: typeof import('axios').default;
  }
}

export {};