import React from 'react';
import {
  AppBar,
  Toolbar,
  IconButton,
  Typography,
  Tooltip,
  Box,
} from '@mui/material';
import {
  AccountBox as AccountBoxIcon,
  Menu as MenuIcon,
} from '@mui/icons-material';

export default function Header() {
  const shopName = 'MyOnlineShop';

  return (
    <AppBar position="static">
      <Toolbar sx={{ justifyContent: 'space-between' }}>
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
          <IconButton color="inherit" aria-label="menu">
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" component="div">
            {shopName}
          </Typography>
        </Box>
        <Box>
          <Tooltip title="Account">
            <IconButton color="inherit" edge="end" aria-label="account">
              <AccountBoxIcon />
            </IconButton>
          </Tooltip>
        </Box>
      </Toolbar>
    </AppBar>
  );
}
