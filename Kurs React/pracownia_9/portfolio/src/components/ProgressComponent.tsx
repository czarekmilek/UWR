import { getRandomColor } from "../utils/randomColor";
import { progressData, frameworkData } from "../data/progressData";

interface ProgressBarProps {
  progress: number;
  label: string;
  color: string;
}

const ProgressBar: React.FC<ProgressBarProps> = ({
  progress,
  label,
  color,
}) => {
  return (
    <div className="grid grid-cols-2 items-center mb-4">
      <p className="text-lg text-right mr-4 font-semibold">{label}</p>
      <div className="h-3 w-96 bg-gray-900 rounded-full relative overflow-hidden">
        <div
          className="h-3 rounded-full animate-fill_bar absolute top-0 left-0"
          style={{
            width: `${progress}%`,
            backgroundColor: color,
          }}
        ></div>
      </div>
    </div>
  );
};

const ProgressComponent = () => {
  return (
    <div className="flex flex-col items-center">
      <h2 className="text-2xl tracking-widest font-bold mb-4 p-2 px-4">
        Languages
      </h2>
      {progressData.map((item) => (
        <ProgressBar
          key={item.label}
          progress={item.progress}
          label={item.label}
          color={getRandomColor()}
        />
      ))}

      <h2 className="text-2xl tracking-widest font-bold mb-4 p-2 px-4">
        Frameworks
      </h2>
      {frameworkData.map((item) => (
        <ProgressBar
          key={item.label}
          progress={item.progress}
          label={item.label}
          color={getRandomColor()}
        />
      ))}
    </div>
  );
};

export default ProgressComponent;
