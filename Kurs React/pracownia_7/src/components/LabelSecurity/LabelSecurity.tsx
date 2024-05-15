import React from 'react';
import * as Label from '@radix-ui/react-label';

const CustomLabelSecurity = () => (
  <div
    style={{
      display: 'flex',
      flexDirection: 'column',
      padding: '0 20px',
      gap: 15,
    }}
  >
    <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
      <Label.Root className="Label" htmlFor="currentPasswordLabel">
        Current Password
      </Label.Root>
      <input
        className="Input"
        type="password"
        id="currentPassword"
        defaultValue=""
      />
    </div>

    <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
      <Label.Root className="Label" htmlFor="newPasswordLabel">
        New Password
      </Label.Root>
      <input
        className="Input"
        type="password"
        id="newPassword"
        defaultValue=""
      />
    </div>

    <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
      <Label.Root className="Label" htmlFor="confirmPasswordLabel">
        Confirm Password
      </Label.Root>
      <input
        className="Input"
        type="password"
        id="confirmPassword"
        defaultValue=""
      />
    </div>
  </div>
);

export default CustomLabelSecurity;
