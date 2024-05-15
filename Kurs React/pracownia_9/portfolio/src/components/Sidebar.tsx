import {
  IoLogoGithub,
  IoLogoYoutube,
  IoLogoLinkedin,
  IoLogoFacebook,
} from "react-icons/io5";

interface SidebarProps {
  heading: string;
}

function Sidebar({ heading }: SidebarProps): JSX.Element {
  return (
    <div
      className="w-28 h-screen bg-slate-800 content-center border-r-2 border-slate-600
     fixed flex flex-col justify-around items-center"
    >
      <h2 className="-rotate-90 tracking-widest text-xl">{heading}</h2>
      <div className="flex flex-col gap-7 text-xl">
        <a
          href="https://github.com"
          className="cursor-pointer hover:scale-125 transition-all ease-in-out"
        >
          <IoLogoGithub />
        </a>
        <a
          href="https://linkedin.com/"
          className="cursor-pointer hover:scale-125 transition-all ease-in-out"
        >
          <IoLogoLinkedin />
        </a>
        <a
          href="https://facebook.com/"
          className="cursor-pointer hover:scale-125 transition-all ease-in-out"
        >
          <IoLogoFacebook />
        </a>
        <a
          href="https://youtube.com"
          className="cursor-pointer hover:scale-125 transition-all ease-in-out"
        >
          <IoLogoYoutube />
        </a>
      </div>
    </div>
  );
}

export default Sidebar;
