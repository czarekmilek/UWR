import React from 'react';
import * as Switch from '@radix-ui/react-switch';
import './styles.css';

const CustomSwitch: React.FC = () => (
  <form>
    <div style={{ display: 'flex', alignItems: 'center' }}>
      <Switch.Root className="SwitchRoot" id="collect-additional-data">
        <Switch.Thumb className="SwitchThumb" />
      </Switch.Root>
    </div>
  </form>
);

export default CustomSwitch;
