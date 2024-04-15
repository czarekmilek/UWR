import styles from './section.module.scss';

interface SectionProps {
  id: string;
  children: React.ReactNode;
}

export default function Section({ id, children }: SectionProps) {
  return (
    <section id={id} className={`${styles['section']} ${id}`}>
      <div className={styles['section-content']}>{children}</div>
    </section>
  );
}
