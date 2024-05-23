import { IoColorPaletteSharp, IoTerminal } from "react-icons/io5";
import { FaServer, FaCode } from "react-icons/fa";
import { AiOutlineSketch } from "react-icons/ai";
import { getRandomColor } from "../utils/randomColor";

export const skills = [
  {
    name: "Web Development",
    icon: (
      <IoTerminal
        className="text-9xl mr-4 "
        style={{ color: getRandomColor() }}
      />
    ),
    description:
      "Excels in creating dynamic websites with a focus on performance and compatibility. Proficient in building dynamic and responsive websites using HTML, CSS, and JavaScript, with experience in various frameworks and libraries.",
  },
  {
    name: "Web Design",
    icon: (
      <IoColorPaletteSharp
        className="text-9xl mr-4"
        style={{ color: getRandomColor() }}
      />
    ),
    description:
      "Designs captivating layouts with a user-centric approach. Skilled in creating visually appealing and user-friendly website layouts, incorporating modern design principles and tools like Adobe XD or Figma.",
  },
  {
    name: "Frontend Development",
    icon: (
      <FaCode className="text-9xl mr-4" style={{ color: getRandomColor() }} />
    ),
    description:
      "Builds interactive interfaces with a keen eye on user experience. Experienced in crafting interactive user interfaces and enhancing user experience through frontend technologies such as React, Vue.js, and Angular.",
  },
  {
    name: "Backend Development",
    icon: (
      <FaServer className="text-9xl mr-4" style={{ color: getRandomColor() }} />
    ),
    description:
      "Develops efficient server-side solutions with a security-first mindset. Capable of developing robust server-side applications and APIs using technologies like Node.js, Express.js, and Django, ensuring efficient data management and processing.",
  },
  {
    name: "UI/UX Design",
    icon: (
      <AiOutlineSketch
        className="text-9xl mr-4"
        style={{ color: getRandomColor() }}
      />
    ),
    description:
      "Designs engaging interfaces tailored to user needs. Adept at designing intuitive user interfaces and seamless user experiences, focusing on usability and aesthetics to create engaging digital products.",
  },
];
