import React from "react";

interface SocialMediaButtonsProps {
  socialMedia: {
    platform: string;
    link: string;
    icon: React.ReactNode;
  }[];
}

const SocialMediaButtons: React.FC<SocialMediaButtonsProps> = ({
  socialMedia,
}) => {
  return (
    <div className="social-media">
      <h3 className="section-title">Social Media</h3>
      <div className="skills-buttons">
        {socialMedia.map(({ platform, link, icon }) => (
          <a
            key={platform}
            href={link}
            className="social-media-button"
            style={{ color: "#6e768d", textDecoration: "none" }}
          >
            {icon}
            {platform}
          </a>
        ))}
      </div>
    </div>
  );
};

export default SocialMediaButtons;
