import { IoArrowForward } from "react-icons/io5";
import { ExpList } from "../data/experienceData";

const Experience = () => {
  return (
    <div className="pl-12 pr-14">
      <div className="flex items-center">
        <div className="w-7 h-3 mb-1 bg-amber-200 rounded-full" />
        <div className="w-full border-[1px] border-slate-500 -mt-1"></div>
        <h2
          className="text-2xl font-bold tracking-widest border-[1px] border-slate-500 
        p-2 pl-4 pr-4 rounded-full"
        >
          EXPERIENCE
        </h2>
        <div className="w-full border-[1px] border-slate-500 -mt-1"></div>
        <div className="w-7 h-3 mb-1 bg-amber-200 rounded-full" />
      </div>

      <div className="flex justify-around mt-6 ">
        {ExpList.map((item) => (
          <div
            className="text-center flex flex-col justify-center items-center"
            style={{ width: `${91 / ExpList.length}%` }}
          >
            <a href={item.link}>
              <div className="rounded-full w-24 h-24">
                <img
                  src={item.logo}
                  className="w-24 h-24 rounded-xl hover:scale-105 transition-all cursor-pointer"
                  alt={item.title}
                />
              </div>
            </a>
            <h2 className="mt-4 font-bold">{item.title}</h2>
            <p className="text-amber-300 text-sm mb-1">{item.years}</p>
            <p className="text-gray-200 text-base">{item.responsibilities}</p>
            <h2 className="mt-2 text-gray-300 text-sm font-sans italic">
              {item.desc}
            </h2>
            <a href={item.link}>
              <IoArrowForward
                className="text-2xl mt-4 bg-amber-200 p-1 rounded-full 
              text-slate-600 hover:scale-110 transition-all cursor-pointer"
              />
            </a>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Experience;
