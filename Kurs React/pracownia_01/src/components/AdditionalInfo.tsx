import React from "react";
import SocialMediaButtons from "./SocialMediaButtons";

interface AdditionalInfoProps {
  address: string;
  socialMedia: {
    platform: string;
    link: string;
    icon: React.ReactNode;
  }[];
  education: string;
}

const AdditionalInfo: React.FC<AdditionalInfoProps> = ({
  address,
  socialMedia,
  education,
}) => {
  return (
    <div className="additional-info">
      <h3 className="section-title">About Me</h3>
      <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum
        dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet,
        consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur
        adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing
        elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      </p>

      <SocialMediaButtons socialMedia={socialMedia} />
      <h3 className="section-title">Additional Info</h3>
      <ul className="experience-list">
        <li>
          <span style={{ color: "#a9b1c0" }}>Address:</span> {address}
        </li>
        <li>
          <span style={{ color: "#a9b1c0" }}>Education:</span> {education}
        </li>
      </ul>

      <style jsx>{`
        .social-media-button {
          background-color: #324455;
          color: #b5b4c6;
          border-radius: 20px;
          padding: 8px 16px;
          margin: 0 10px 10px 0;
          display: inline-block;
          cursor: default;
          display: flex;
          align-items: center;
          text-decoration: none;
        }
        .social-media-button:last-child {
          margin-right: 0;
        }
        .social-media-icon {
          margin-right: 8px;
          fill: #b5b4c6;
        }
      `}</style>
    </div>
  );
};

export default AdditionalInfo;
