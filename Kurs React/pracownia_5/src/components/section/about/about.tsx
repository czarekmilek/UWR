import Section from '../section';

interface AboutProps {
  about: string;
}

export default function About({ about }: AboutProps) {
  return (
    <Section id="about">
      <div className="section-content">
        <h2>About Us</h2>
        <p>{about}</p>
      </div>
    </Section>
  );
}
