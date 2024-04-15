import React from "react";

interface ContactInfoProps {
  email: string;
  phone: string;
  website: string;
}

const ContactInfo: React.FC<ContactInfoProps> = ({ email, phone, website }) => {
  const contactInfoStyles: React.CSSProperties = {
    backgroundColor: "#111827",
    padding: "20px",
    borderRadius: "0 0 0 10px",
    width: "250px",
    height: "240px",
  };

  const labelStyles: React.CSSProperties = {
    fontWeight: "bold",
    marginBottom: "4px",
    color: "white",
  };

  const detailsStyles: React.CSSProperties = {
    color: "#8f98a3",
  };

  return (
    <div style={contactInfoStyles} className="contact-info">
      <p style={labelStyles}>✉ Email:</p>
      <p style={detailsStyles}>{email}</p>
      <p style={labelStyles}>✆ Phone:</p>
      <p style={detailsStyles}>{phone}</p>
      <p style={labelStyles}>⚛︎ Website:</p>
      <p style={detailsStyles}>{website}</p>
    </div>
  );
};

export default ContactInfo;
