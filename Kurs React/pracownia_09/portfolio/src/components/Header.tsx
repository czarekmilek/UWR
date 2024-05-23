import { Link } from "react-router-dom";

function Header() {
  const menu = [
    {
      id: 1,
      name: "HOME",
      path: "/",
    },
    {
      id: 2,
      name: "ABOUT ME",
      path: "/about",
    },
    {
      id: 3,
      name: "SKILLS",
      path: "/skills",
    },
    {
      id: 4,
      name: "PROJECTS",
      path: "/projects",
    },
  ];

  return (
    <div className="flex items-center w-screen justify-between bg-slate-800 border-b-2 border-slate-600">
      <div className="w-28 h-28 bg-amber-400 content-center">
        <a href="/">
          <img
            src="./batlogo.png"
            className="p-2 hover:scale-110 transition-all ease-in-out"
            alt="logo"
          ></img>
        </a>
      </div>
      <div className="hidden md:flex gap-20">
        {menu.map((item) => (
          <Link
            key={item.id}
            to={item.path}
            className="cursor-pointer hover:underline text-xl hover:scale-105 transition-all ease-in-out"
          >
            <h2>{item.name}</h2>
          </Link>
        ))}
      </div>
      <div className="w-28 h-28 bg-slate-800 content-center"></div>
    </div>
  );
}

export default Header;
