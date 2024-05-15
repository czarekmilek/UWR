import React from 'react';
import * as Label from '@radix-ui/react-label';
import './styles.css';

const CustomLabel = () => (
  <div
    style={{
      display: 'flex',
      flexDirection: 'column',
      padding: '0 20px',
      gap: 15,
    }}
  >
    <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
      <Label.Root className="Label" htmlFor="username">
        Username
      </Label.Root>
      <input
        className="Input"
        type="text"
        id="username"
        defaultValue="@cezarymilek"
      />
    </div>

    <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
      <Label.Root className="Label" htmlFor="name">
        Name
      </Label.Root>
      <input
        className="Input"
        type="text"
        id="name"
        defaultValue="Cezary Miłek"
      />
    </div>
  </div>
);

export default CustomLabel;
