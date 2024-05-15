import React from 'react';

interface BlogPostProps {
  title: string;
  date: string;
  content: string;
}

const BlogPost: React.FC<BlogPostProps> = ({ title, date, content }) => {
  return (
    <div className={`blog-post bg-[#F0F0F0] dark:bg-[#222222] text-left p-5 rounded-[10px]`}>
      <h3 className="text-[1.17em] font-bold mb-[10px] mt-[18.72px]">{title}</h3>
      <p className="mb-[6px] mt-[16px]">{date}</p>
      <p className="mb-[6px] mt-[14px]">{content}</p>
      <button className={`cursor-pointer transition-[background-color] duration-[0.3s] ease-[ease] 
                          py-[3px] px-[10px] rounded-[5px] border-[none] bg-[#4CAF50] hover:bg-[#45a049]} 
                          text-white text-[13.333px] font-arial rounded`}>
        Read More
      </button>
    </div>
  );
};

export default BlogPost;
