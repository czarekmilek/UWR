import React, { useState } from 'react';
import {
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  TextField,
} from '@mui/material';
import AddIcon from '@mui/icons-material/Add';

export default function AddProduct({ data, updateData, onClose }) {
  const [nameError, setNameError] = useState(false);
  const [typeError, setTypeError] = useState(false);
  const [priceError, setPriceError] = useState(false);
  const [quantityError, setQuantityError] = useState(false);

  const handleNameChange = (event) => {
    const name = event.target.value.trim();
    setNameError(name === '');
  };

  const handleTypeChange = (event) => {
    const type = event.target.value.trim();
    setTypeError(type === '');
  };

  const handlePriceChange = (event) => {
    const price = event.target.value.trim();
    setPriceError(price === '' || isNaN(parseFloat(price)));
  };

  const handleQuantityChange = (event) => {
    const quantity = event.target.value.trim();
    setQuantityError(quantity === '' || isNaN(parseInt(quantity)));
  };

  const handleSubmit = () => {
    if (!nameError && !typeError && !priceError && !quantityError) {
      const formData = new FormData(
        document.getElementById('add-product-form')
      );
      const newProduct = {
        id: data.length + 1,
        name: formData.get('name'),
        type: formData.get('type'),
        price: parseFloat(formData.get('price')),
        quantity: parseInt(formData.get('quantity')),
        available: parseInt(formData.get('quantity')) > 0,
      };
      updateData([...data, newProduct]);
      onClose();
    }
  };

  return (
    <Dialog open={true} onClose={onClose}>
      <DialogTitle>Add Product</DialogTitle>
      <DialogContent>
        <form id="add-product-form">
          <TextField
            autoFocus
            required
            label="Name"
            id="name"
            name="name"
            type="text"
            margin="dense"
            fullWidth
            error={nameError}
            onChange={handleNameChange}
            helperText={nameError ? 'Invalid name' : ''}
          />
          <TextField
            required
            label="Type"
            id="type"
            name="type"
            type="text"
            margin="dense"
            fullWidth
            error={typeError}
            onChange={handleTypeChange}
            helperText={typeError ? 'Invalid type' : ''}
          />
          <TextField
            required
            label="Price"
            id="price"
            name="price"
            type="number"
            margin="dense"
            fullWidth
            error={priceError}
            onChange={handlePriceChange}
            helperText={priceError ? 'Invalid price' : ''}
          />
          <TextField
            required
            label="Quantity"
            id="quantity"
            name="quantity"
            type="number"
            margin="dense"
            fullWidth
            error={quantityError}
            onChange={handleQuantityChange}
            helperText={quantityError ? 'Invalid quantity' : ''}
          />
        </form>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose}>Cancel</Button>
        <Button onClick={handleSubmit} startIcon={<AddIcon />}>
          Add
        </Button>
      </DialogActions>
    </Dialog>
  );
}
