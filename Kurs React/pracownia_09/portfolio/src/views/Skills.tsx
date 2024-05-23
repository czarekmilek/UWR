import Sidebar from "../components/Sidebar";
import ProgressComponent from "../components/ProgressComponent";
import SkillInfo from "../components/SkillInfo";

const Skills = () => {
  return (
    <>
      <Sidebar heading="SKILLS" />
      <div className="flex justify-center flex-col items-center">
        <div className="h-9 border-r-2 border-slate-600" />
      </div>
      <div className="pl-8 pr-10 flex justify-center flex-col items-center">
        <div className="flex items-center">
          <div className="w-3 h-3 rounded-full bg-amber-200" />
          <div className="w-96 border-[1px] border-slate-500 rounded-t-full" />
          <h2
            className="text-2xl tracking-widest font-bold mb-4 p-2 px-4 border-[1px]
        border-slate-500 rounded-full"
          >
            SKILLS
          </h2>
          <div className="w-96 border-[1px] border-slate-500 rounded-t-full" />
          <div className="h-3 w-3 rounded-full bg-amber-200" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <ProgressComponent />
          <SkillInfo />
        </div>
      </div>
    </>
  );
};

export default Skills;
