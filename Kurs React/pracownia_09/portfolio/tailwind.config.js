/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      animation: {
        fill_bar: "fill_bar 2s forwards",
      },
      keyframes: {
        fill_bar: {
          "0%": { width: "0%" },
          "100%": { width: "var(100%, --progress)" },
        },
      },
    },
  },
  plugins: [],
};
