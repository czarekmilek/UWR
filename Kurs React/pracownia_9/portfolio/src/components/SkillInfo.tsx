import { skills } from "../data/skillsData";

const SkillInfo = () => {
  return (
    <div className="flex flex-col -mt-4 items-left">
      {skills.map((skill, index) => (
        <div key={index} className="flex -ml-4 mt-4 items-center w-8/12">
          <div className="scale-[55%] -mr-2">{skill.icon}</div>
          <div>
            <p className="font-bold items-right tracking-widest">{skill.name}</p>
            <p className="text-left">{skill.description}</p>
          </div>
        </div>
      ))}
    </div>
  );
};

export default SkillInfo;
