import React from "react";

interface BusinessCardProps {
  name: string;
  jobTitle: string;
  company: string;
}

const businessCardStyles: React.CSSProperties = {
  padding: "20px",
  borderRadius: "10px 0 0 0",
  backgroundColor: "#111827",
  textAlign: "center",
  width: "250px",
  height: "320px",
};

const imageStyles: React.CSSProperties = {
  width: "150px",
  height: "150px",
  borderRadius: "50%",
  border: "2px solid #9ba2aa",
  objectFit: "cover",
  marginBottom: "15px",
};

const nameStyles: React.CSSProperties = {
  fontSize: "1.5rem",
  fontWeight: "bold",
  marginBottom: "10px",
  color: "white",
};

const jobTitleStyles: React.CSSProperties = {
  fontSize: "1.4rem",
  color: "#d1d5db",
};

const companyStyles: React.CSSProperties = {
  fontSize: "1.2rem",
  color: "#9ba2aa",
};

const BusinessCard: React.FC<BusinessCardProps> = ({
  name,
  jobTitle,
  company,
}) => {
  return (
    <div style={businessCardStyles} className="business-card">
      <img
        src={
          "https://cdn.pixabay.com/photo/2024/01/15/11/36/batman-8510027_640.png"
        }
        alt={name}
        style={imageStyles}
      />
      <h1 style={nameStyles}>{name}</h1>
      <p style={jobTitleStyles}>{jobTitle}</p>
      <p style={companyStyles}>{company}</p>
    </div>
  );
};

export default BusinessCard;
