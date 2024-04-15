import styles from './team.module.scss';
import Section from '../section';

interface TeamProps {
  teamMembers: {
    id: number;
    image: string;
    name: string;
    position: string;
    bio: string;
  }[];
}

export default function Team({ teamMembers }: TeamProps) {
  return (
    <Section id="team">
      <h2>Meet Our Team</h2>
      <div className={styles['team-members']}>
        {teamMembers.map((member) => (
          <div key={member.id} className={styles['team-member']}>
            <img src={member.image} alt={member.name} />
            <div>
              <h3>{member.name}</h3>
              <p>{member.position}</p>
              <p>{member.bio}</p>
            </div>
          </div>
        ))}
      </div>
    </Section>
  );
}
