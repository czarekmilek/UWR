import educationData from "../data/educationData";

const Education = () => {
  return (
    <div className="mt-8 -mb-7 pl-8 pr-10 flex justify-center flex-col items-center">
      <div className="flex items-center">
        <div className="w-3 h-3 rounded-full bg-amber-200" />
        <div className="w-64 border-[1px] border-slate-500 rounded-t-full" />
        <h2 className="text-2xl tracking-widest font-bold mb-4 p-2 px-4 border-[1px] border-slate-500 rounded-full">
          EDUCATION
        </h2>
        <div className="w-64 border-[1px] border-slate-500 rounded-t-full" />
        <div className="h-3 w-3 rounded-full bg-amber-200" />
      </div>

      <div className="grid grid-cols-2 ml-6">
        {educationData.map((data, index) => (
          <div className="flex" key={index}>
            <div className="w-full mt-2 bg-neutral-800 shadow-md rounded-lg p-6 mr-5 border-2 border-gray-800 mb-6">
              <div className="flex items-center">
                <img
                  src={data.image}
                  alt={data.institution}
                  className="w-24 h-24 mr-6"
                />
                <div>
                  <a href={data.link}>
                    <h3 className="text-lg font-semibold hover:underline">
                      {data.institution}
                    </h3>
                  </a>
                  <p className="text-gray-200">
                    <span className="text-amber-300">Years of Attendance:</span>{" "}
                    {data.yearsOfAttendance}
                  </p>
                  <p className="text-gray-200">
                    <span className="text-amber-300">GPA:</span> {data.gpa}
                  </p>
                  {data.majors && (
                    <p className="text-gray-200">
                      <span className="text-amber-300">Majors:</span>{" "}
                      {data.majors.join(", ")}
                    </p>
                  )}
                  {data.major && (
                    <p className="text-gray-200">
                      <span className="text-amber-300">Major:</span>{" "}
                      {data.major}
                    </p>
                  )}
                  <p className="text-gray-300 italic font-sans">
                    "{data.description}"
                  </p>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Education;
