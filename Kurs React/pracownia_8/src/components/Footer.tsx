import React from 'react';

interface FooterProps {
  companyName: string;
}

const Footer: React.FC<FooterProps> = ({ companyName }) => {
  return (
    <footer className={`bg-white dark:bg-[#111111] footer py-12`}>
      <div className="footer-content text-center">
        <p className={`text-base text-[#333] dark:text-white mt-4`}>
          &copy; {new Date().getFullYear()} {companyName}
        </p>
      </div>
    </footer>
  );
};

export default Footer;
