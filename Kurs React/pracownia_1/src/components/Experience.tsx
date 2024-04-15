import React from "react";

interface ExperienceProps {
  experience: string[];
}

const Experience: React.FC<ExperienceProps> = ({ experience }) => {
  return (
    <div className="experience">
      <h3 className="section-title">Experience</h3>
      <ul className="experience-list">
        {experience.map((exp, index) => (
          <li key={index}>{exp}</li>
        ))}
      </ul>
    </div>
  );
};

export default Experience;
