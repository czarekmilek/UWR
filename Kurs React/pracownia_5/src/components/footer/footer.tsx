import styles from './footer.module.scss';

interface FooterProps {
  name: string;
}

export default function Footer({ name }: FooterProps) {
  return (
    <footer className={styles['footer']}>
      <div className={styles['footer-content']}>
        <p>
          &copy; {new Date().getFullYear()} {name}
        </p>
      </div>
    </footer>
  );
}
