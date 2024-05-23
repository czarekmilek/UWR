import React from "react";

interface SkillsProps {
  skills: string[];
}

const Skills: React.FC<SkillsProps> = ({ skills }) => {
  return (
    <div className="skills">
      <h3 className="section-title">Skills</h3>
      <div className="skills-buttons">
        {skills.map((skill, index) => (
          <div key={index} className="skill-button">
            {skill}
          </div>
        ))}
      </div>
    </div>
  );
};

export default Skills;
