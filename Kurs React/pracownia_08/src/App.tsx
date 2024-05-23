import { useState, useEffect } from 'react';
import Navbar from './components/Navbar';
import Header from './components/Header';
import ContentCard from './components/ContentCard';
import Section from './components/Section';
import ServiceList from './components/ServiceList';
import TeamMember from './components/TeamMember';
import BlogPost from './components/BlogPost';
import ContactForm from './components/ContactForm';
import Footer from './components/Footer';

const companyData = {
  name: 'Acme Corporation',
  slogan: 'Innovation at its best',
  about:
    'We are a leading provider of innovative solutions in various industries. Our team is dedicated to delivering high-quality products and services to our clients worldwide.',
  services: [
    {
      id: 1,
      name: 'Web Development',
      description: 'Creating modern and responsive websites.',
    },
    {
      id: 2,
      name: 'Mobile App Development',
      description: 'Building mobile applications for iOS and Android.',
    },
    {
      id: 3,
      name: 'UI/UX Design',
      description:
        'Designing intuitive user interfaces for optimal user experience.',
    },
    {
      id: 4,
      name: 'Digital Marketing',
      description:
        'Promoting products and services through various online channels.',
    },
  ],
  teamMembers: [
    {
      id: 1,
      name: 'Alice Young',
      position: 'CEO',
      bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis libero et nisi cursus, sit amet laoreet odio rutrum.',
      image: 'https://via.placeholder.com/150',
    },
    {
      id: 2,
      name: 'Jane Smith',
      position: 'CTO',
      bio: 'Duis aliquam purus ac ante volutpat, nec lobortis tortor sagittis. Sed finibus eleifend efficitur.',
      image: 'https://via.placeholder.com/150',
    },
    {
      id: 3,
      name: 'Alice Johnson',
      position: 'Lead Designer',
      bio: 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris consectetur, velit et efficitur fringilla, ligula felis dignissim.',
      image: 'https://via.placeholder.com/150',
    },
  ],
  blogPosts: [
    {
      id: 1,
      title: 'The Future of Technology',
      date: 'March 10, 2024',
      content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis libero et nisi cursus, sit amet laoreet odio rutrum.',
    },
    {
      id: 2,
      title: 'Design Trends for 2024',
      date: 'February 28, 2024',
      content:
        'Duis aliquam purus ac ante volutpat, nec lobortis tortor sagittis. Sed finibus eleifend efficitur.',
    },
    {
      id: 3,
      title: 'The Power of Social Media',
      date: 'February 15, 2024',
      content:
        'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris consectetur, velit et efficitur fringilla, ligula felis dignissim.',
    },
    {
      id: 4,
      title: 'Artificial Intelligence in Business',
      date: 'January 30, 2024',
      content:
        'Suspendisse eget sapien vitae eros tincidunt ultrices. Morbi nec sem nisi. Nulla ultrices odio et eros varius, a eleifend velit tristique.',
    },
    {
      id: 5,
      title: 'The Impact of Virtual Reality',
      date: 'January 15, 2024',
      content:
        'Integer auctor neque mauris, eget sagittis justo tristique sit amet. Nam at nibh et nulla suscipit blandit eu nec mi.',
    },
  ],
};

const App = () => {
  const [darkMode, setDarkMode] = useState(() => {
    return localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches);
  });

  useEffect(() => {
    localStorage.theme = darkMode ? 'dark' : 'light';
    document.documentElement.classList.toggle('dark', darkMode);
  }, [darkMode]);

  const toggleTheme = () => {
    setDarkMode(!darkMode);
  };

  return (
    <div className="portfolio text-black dark:text-[#FFFFFF]">
      <Navbar darkMode={darkMode} toggleTheme={toggleTheme} />
      <div className={`bg-[#FFFFFF] dark:bg-[#111111]`}>
        <Header companyName={companyData.name} slogan={companyData.slogan} />
      </div>
      <ContentCard>
        <div className={`bg-[#EEEEEE] dark:bg-[#333]`}>
        <Section id="about" title="About Us">
          <p>{companyData.about}</p>
        </Section>
        </div>
        <div className={`bg-[#F5F5F5] dark:bg-[#444444]`}>
        <Section id="services" title="Our Services">
          <ServiceList services={companyData.services} />
        </Section>
        </div>
        <div className={`bg-[#EEEEEE] dark:bg-[#333] mt-[-10px]`}>
        <Section id="team" title="Meet Our Team" >
          <div className={`team-members flex flex-wrap justify-center mt-[-10px] mb-[-20px]`}>
            {companyData.teamMembers.map((member) => (
              <TeamMember
                key={member.id}
                name={member.name}
                position={member.position}
                bio={member.bio}
                image={member.image}
              />
            ))}
          </div>
        </Section>
        </div>
        <div className={`bg-[#F5F5F5] dark:bg-[#444444]`}>
        <Section id="blog" title="Latest Blog Posts">
          <div className={`grid grid-cols-[repeat(auto-fit,minmax(300px,1fr))] gap-5`}>{companyData.blogPosts.map((post) => (
            <BlogPost
              key={post.id}
              title={post.title}
              date={post.date}
              content={post.content}
            />
          ))} 
          </div>
        </Section>
        </div>
        <div className={`bg-[#EEEEEE] dark:bg-[#333] mt-[-20px]`}>
        <Section id="contact" title="Contact Us">
          <ContactForm />
        </Section>
        </div>
      </ContentCard>
      <Footer companyName={companyData.name} />
    </div>
  );
};

export default App;
