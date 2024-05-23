import React from 'react';
import * as Avatar from '@radix-ui/react-avatar';
import './styles.css';

const CustomAvatar = () => (
  <div style={{ display: 'flex', gap: 20 }}>
    <Avatar.Root className="AvatarRoot">
      <Avatar.Image
        className="AvatarImage"
        src="https://images.unsplash.com/photo-1492633423870-43d1cd2775eb?&w=128&h=128&dpr=2&q=80"
        alt="Colm Tuite"
      />
    </Avatar.Root>
  </div>
);

export default CustomAvatar;
