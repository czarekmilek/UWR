import styles from './blog.module.scss';
import Section from '../section';

interface BlogProps {
  blogdata: {
    id: number;
    title: string;
    date: string;
    content: string;
  }[];
}

export default function Blog({ blogdata }: BlogProps) {
  return (
    <Section id={styles['blog']}>
      <h2>Latest Blog Posts</h2>
      <div className={styles['blog-posts']}>
        {blogdata.map((post) => (
          <div key={post.id} className={styles['blog-post']}>
            <h3>{post.title}</h3>
            <p>{post.date}</p>
            <p>{post.content}</p>
            <button>Read More</button>
          </div>
        ))}
      </div>
    </Section>
  );
}
