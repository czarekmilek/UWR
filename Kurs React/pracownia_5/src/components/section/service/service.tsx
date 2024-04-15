import styles from './service.module.scss';
import Section from '../section';

interface ServiceProps {
  services: {
    id: number;
    name: string;
    description: string;
  }[];
}

export default function Service({ services }: ServiceProps) {
  return (
    <Section id={styles['services']}>
      <h2>Our Services</h2>
      <ul>
        {services.map((service) => (
          <li key={service.id}>
            <h3>{service.name}</h3>
            <p>{service.description}</p>
          </li>
        ))}
      </ul>
    </Section>
  );
}
