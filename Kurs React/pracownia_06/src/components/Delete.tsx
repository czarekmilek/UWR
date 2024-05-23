import React from 'react';
import { Button, Dialog, DialogActions, DialogContent } from '@mui/material';

export default function Delete({ name, onClose }) {
  return (
    <Dialog open={true} onClose={onClose}>
      <DialogContent>{`Deleted product: ${name}`}</DialogContent>
      <DialogActions>
        <Button onClick={onClose}>Close</Button>
      </DialogActions>
    </Dialog>
  );
}
