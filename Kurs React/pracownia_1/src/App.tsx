import React from "react";
import Content from "./components/Content";
import "./styles.css";

const App: React.FC = () => {
  return (
    <div className="app">
      <div className="container">
        <Content />
      </div>
    </div>
  );
};

export default App;
