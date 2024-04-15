import styles from './header.module.scss';

interface HeaderProps {
  name: string;
  text: string;
}

export default function Header({ name, text }: HeaderProps) {
  return (
    <header id="header" className={styles['header']}>
      <div className={styles['header-content']}>
        <h1>{name}</h1>
        <p>{text}</p>
      </div>
    </header>
  );
}
