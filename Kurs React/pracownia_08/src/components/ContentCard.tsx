import React from 'react';

interface ContentCardProps {
  children: React.ReactNode;
}

const ContentCard: React.FC<ContentCardProps> = ({ children }) => {
  return (
    <div className={`content-card mx-0 rounded-[10px]`}>
      {children}
    </div>
  );
};

export default ContentCard;
