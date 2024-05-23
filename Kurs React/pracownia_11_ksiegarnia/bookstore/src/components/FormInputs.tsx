import React from 'react';
import InputField from './InputField';
import { Book } from '../types/Book';
import { Genre } from '../types/Genre';

interface FormInputsProps {
  formData: Book;
  setFormData: (data: Partial<Book>) => void;
  errors: { [key: string]: string };
  genres: Genre[];
}

const FormInputs: React.FC<FormInputsProps> = ({ formData, setFormData, errors, genres }) => {
  return (
    <>
      <InputField
        label="Title"
        type="text"
        value={formData.title}
        onChange={(e) => setFormData({ ...formData, title: e.target.value })}
        error={errors.title}
      />
      <InputField
        label="Author"
        type="text"
        value={formData.author}
        onChange={(e) => setFormData({ ...formData, author: e.target.value })}
        error={errors.author}
      />
      <InputField
        label="Year"
        type="text"
        value={formData.year}
        onChange={(e) => setFormData({ ...formData, year: e.target.value })}
        error={errors.year}
      />
      <InputField
        label="Copies"
        type="number"
        value={formData.copies}
        min={0}
        onChange={(e) => setFormData({ ...formData, copies: Math.max(0, +e.target.value) })}
        error={errors.copies}
      />
      <InputField
        label="Price"
        type="number"
        step="0.01"
        min={0}
        value={formData.price}
        onChange={(e) => setFormData({ ...formData, price: Math.max(0, +e.target.value) })}
        error={errors.price}
      />
      <InputField
        label="Genre"
        type="select"
        value={formData.genreId}
        onChange={(e) => setFormData({ ...formData, genreId: e.target.value })}
        error={errors.genreId}
        options={genres}
      />
    </>
  );
};

export default FormInputs;
