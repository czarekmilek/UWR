import React from 'react';

interface NavbarProps {
  darkMode: boolean;
  toggleTheme: () => void;
}

const Navbar: React.FC<NavbarProps> = ({ darkMode, toggleTheme }) => {
  return (
    <nav className={`bg-[#f0f0f0] dark:bg-[#222] navbar sticky top-0 py-2.5 text-center z-[1000]`}>
      <a href="#header" className={`text-[#333] dark:text-white px-5 py-0 no-underline`}>Home</a>
      <a href="#about" className={`text-[#333] dark:text-white px-5 py-0 no-underline`}>About</a>
      <a href="#services" className={`text-[#333] dark:text-white px-5 py-0 no-underline`}>Services</a>
      <a href="#team" className={`text-[#333] dark:text-white px-5 py-0 no-underline`}>Team</a>
      <a href="#blog" className={`text-[#333] dark:text-white px-5 py-0 no-underline`}>Blog</a>
      <a href="#contact" className={`text-[#333] dark:text-white px-5 py-0 no-underline`}>Contact</a>
      <button
        onClick={toggleTheme}
        className={`theme-toggle-button dark:bg-[#ddd] dark:text-[#333] bg-[#333] text-white 
                    cursor-pointer transition-[background-color] duration-[0.3s] ease-[ease] rounded-[5px] px-5 py-2.5`}
      >
        {darkMode ? 'Light Mode' : 'Dark Mode'}
      </button>
    </nav>
  );
};

export default Navbar;
