import React from 'react';

interface Service {
  id: number;
  name: string;
  description: string;
}

interface ServiceListProps {
  services: Service[];
}

const ServiceList: React.FC<ServiceListProps> = ({ services }) => {
  return (
      <ul className={`services-list mb-6`}>
      {services.map((service) => (
        <li key={service.id} className="mb-[10px] mt-[28.8px]">
          <h3 className={`text-[28.8px] font-bold mb-2`}>{service.name}</h3>
          <p>{service.description}</p>
        </li>
      ))}
    </ul>
  );
};

export default ServiceList;
