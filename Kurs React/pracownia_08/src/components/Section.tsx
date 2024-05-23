import React, { ReactNode } from 'react';

interface SectionProps {
  id: string;
  title: string;
  children: ReactNode;
}

const Section: React.FC<SectionProps> = ({ id, title, children }) => {
  return (
    <section id={id} className={`section py-10`}>
      <div className="section-content max-w-[800px] mx-auto">
        <h2 className={`text-[2.5em] font-bold mb-8`}>{title}</h2>
        {children}
      </div>
    </section>
  );
};

export default Section;
