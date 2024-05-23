import React from "react";
import AdditionalInfo from "./AdditionalInfo";
import Skills from "./Skills";
import Experience from "./Experience";

interface SidebarProps {
  address: string;
  socialMedia: {
    platform: string;
    link: string;
    icon: React.ReactNode;
  }[];
  education: string;
  experience: string[];
  skills: string[];
}

const Sidebar: React.FC<SidebarProps> = (props) => {
  return (
    <div className="sidebar">
      <AdditionalInfo
        address={props.address}
        socialMedia={props.socialMedia}
        education={props.education}
      />
      <Experience experience={props.experience} />
      <Skills skills={props.skills} />
      <style jsx>{`
        .sidebar {
          background-color: #1f2937;
          color: #8f98a3;
          border-radius: 0 10px 10px 0;
          padding: 20px;
          width: 600px;
          height: 600px;
        }
        .additional-info,
        .skills {
          margin-bottom: 20px;
        }
        .section-title {
          color: #fff;
          font-size: 20px;
          margin-bottom: 10px;
        }
        .experience-list {
          list-style-type: square;
          padding-left: 20px;
        }
        .skill-button {
          background-color: #324455;
          color: #b5b4c6;
          border-radius: 20px;
          padding: 8px 16px;
          margin: 0 15px 10px 0;
          display: inline-block;
          cursor: default;
          display: flex;
          align-items: center;
        }
        .skill-button:last-child {
          margin-right: 0;
        }
        .skills-buttons {
          display: flex;
          flex-wrap: wrap;
          justify-content: center;
        }
      `}</style>
    </div>
  );
};

export default Sidebar;
