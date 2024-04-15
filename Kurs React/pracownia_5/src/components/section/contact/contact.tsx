import styles from './contact.module.scss';
import Section from '../section';

export default function Contact() {
  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
  };

  return (
    <Section id={styles['contact']}>
      <h2>Contact Us</h2>
      <form onSubmit={handleSubmit} className={styles['contact-form']}>
        <div className={styles['form-group']}>
          <input type="text" placeholder="Name" required />
        </div>
        <div className={styles['form-group']}>
          <input type="email" placeholder="Email" required />
        </div>
        <div className={styles['form-group']}>
          <textarea rows={5} placeholder="Message" required></textarea>
        </div>
        <button type="submit">Send Message</button>
      </form>
    </Section>
  );
}
