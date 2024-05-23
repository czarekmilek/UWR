import Sidebar from "../components/Sidebar";
import ProfilePicture from "../components/ProfilePicture";
import Introduction from "../components/Introduction";

export default function Home() {
  return (
    <>
      <Sidebar heading="HOMEPAGE" />
      <div className="ml-32 grid grid-cols-1 md:grid-cols-3">
        <div className="col-span-2">
          <Introduction />
        </div>
        <div className="hidden md:block">
          <ProfilePicture />
        </div>
      </div>
    </>
  );
}
