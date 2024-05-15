import React from 'react';

interface TeamMemberProps {
  name: string;
  position: string;
  bio: string;
  image: string;
}

const TeamMember: React.FC<TeamMemberProps> = ({ name, position, bio, image }) => {
  return (
    <div className={`team-member bg-[#f5f5f5] dark:bg-[#444] flex-[0_0_calc(40%_-_20px)] text-center m-2.5 p-8 pt-6`}>
      <img src={image} alt={name} className="mb-8 rounded-[50%] px-11" />
      <div className="text-center">
        <h3 className={`text-xl font-bold inline-block mb-2 `}>{name}</h3>
        <p className={`mt-4`}>{position}</p>
        <p className={`mt-4`}>{bio}</p>
      </div>
    </div>
  );
};

export default TeamMember;
