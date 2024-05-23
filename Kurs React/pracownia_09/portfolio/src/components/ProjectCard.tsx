import { Project } from "../types/Project";

interface Props {
  project: Project;
}

export default function ProjectCard({ project }: Props): JSX.Element {
  const { title, description, githubLink, technologies, showcaseImage } =
    project;

  return (
    <div className="bg-neutral-800 shadow-lg rounded-lg overflow-hidden relative">
      <div className="p-6 h-80">
        <h2 className="text-xl font-semibold mb-2">{title}</h2>
        <p className="text-gray-400 mb-4">{description}</p>
        <div className="flex flex-row">
          <div className="w-40 h-40 -mt-5">
            <img
              className="object-cover object-center mr-6 mt-2 p-6"
              src={showcaseImage}
              alt={title}
            />
          </div>
          <div className="mb-4">
            <h3 className="text-lg font-semibold mb-2">Technologies Used:</h3>
            <ul className="list-disc list-inside">
              {technologies.map((tech, index) => (
                <li key={index}>{tech}</li>
              ))}
            </ul>
          </div>
        </div>
        <a
          href={githubLink}
          className="text-cyan-500 hover:text-cyan-700 transition duration-300 absolute -bottom-1 left-0 ml-6 mb-6"
        >
          View on GitHub
        </a>
      </div>
    </div>
  );
}
