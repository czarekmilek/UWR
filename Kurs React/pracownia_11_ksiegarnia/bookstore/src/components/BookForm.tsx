import React, { useState, useEffect } from "react";
import axios from "axios";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { Book } from "../types/Book";
import { Genre } from "../types/Genre";
import FormInputs from "./FormInputs";

const createBook = async (newBook: Book) => {
  const { data } = await axios.post("http://localhost:3000/books", newBook);
  return data;
};

const updateBook = async (updatedBook: Book) => {
  const { data } = await axios.put(
    `http://localhost:3000/books/${updatedBook.id}`,
    updatedBook
  );
  return data;
};

interface BookFormProps {
  onClose: () => void;
  initialData?: Book;
}

const BookForm: React.FC<BookFormProps> = ({ onClose, initialData }) => {
  const queryClient = useQueryClient();
  const [formData, setFormData] = useState<Book>({
    id: "",
    title: "",
    author: "",
    year: "",
    copies: 0,
    price: 0,
    genreId: "",
  });
  const [genres, setGenres] = useState<Genre[]>([]);
  const [errors, setErrors] = useState<{ [key: string]: string }>({});

  useEffect(() => {
    if (initialData) {
      setFormData(initialData);
    }
    axios.get("http://localhost:3000/genres").then((response) => {
      setGenres(response.data);
    });
  }, [initialData]);

  const createBookMutation = useMutation({
    mutationFn: createBook,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["books"] });
      onClose();
    },
  });

  const updateBookMutation = useMutation({
    mutationFn: updateBook,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["books"] });
      onClose();
    },
  });

  const validateForm = () => {
    const newErrors: { [key: string]: string } = {};
    if (!formData.title) newErrors.title = "Title is required";
    if (!formData.author) newErrors.author = "Author is required";
    if (!formData.year) newErrors.year = "Year is required";
    if (formData.copies < 0) newErrors.copies = "Copies cannot be negative";
    if (formData.price < 0) newErrors.price = "Price cannot be negative";
    if (!formData.genreId) newErrors.genreId = "Genre is required";
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (validateForm()) {
      if (initialData) {
        updateBookMutation.mutate(formData);
      } else {
        createBookMutation.mutate(formData);
      }
    }
  };

  return (
    <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex items-center justify-center tracking-wider">
      <div className="bg-zinc-900 p-8 rounded-lg shadow-lg w-full max-w-lg">
        <h2 className="text-2xl font-bold mb-4 tracking-wider">
          {initialData ? "Edit book" : "Add a new book"}
        </h2>
        <form onSubmit={handleSubmit}>
          <FormInputs
            formData={formData}
            setFormData={(data) => setFormData({ ...formData, ...data })}
            errors={errors}
            genres={genres}
          />
          <div className="flex justify-end mt-5 tracking-widest">
            <button
              type="button"
              className="bg-gradient-to-b from-gray-500 to-gray-800 text-white p-3 rounded mr-3 w-20 
              hover:bg-gradient-to-b hover:from-gray-700 hover:to-gray-900 transition ease-in-out hover:scale-110 duration-300"
              onClick={onClose}
            >
              Cancel
            </button>
            <button
              type="submit"
              className="bg-gradient-to-b from-blue-500 to-blue-800 text-white p-3 rounded w-20
              hover:bg-gradient-to-b hover:from-blue-700 hover:to-blue-900 
              transition ease-in-out hover:translate-y-0.5 hover:scale-110 duration-300"
            >
              {initialData ? "Update" : "Add"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default BookForm;
