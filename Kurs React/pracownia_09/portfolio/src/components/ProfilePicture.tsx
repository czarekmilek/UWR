import { Component } from "react";

export class ProfilePicture extends Component {
  render() {
    return (
      <div className="fixed border-l-2 border-slate-600">
        <img src="./batman.png" className="h-screen object-cover"></img>
      </div>
    );
  }
}

export default ProfilePicture;
