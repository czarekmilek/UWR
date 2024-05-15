import React from 'react';

interface HeaderProps {
  companyName: string;
  slogan: string;
}

const Header: React.FC<HeaderProps> = ({ companyName, slogan }) => {
  return (
    <header id="header" className="header py-[85px]">
      <div className="header-content text-center">
        <h1 className="text-[3em] md:text-[4xl] font-bold mb-4">{companyName}</h1>
        <p className="text-[1.5em]">{slogan}</p>
      </div>
    </header>
  );
};

export default Header;
