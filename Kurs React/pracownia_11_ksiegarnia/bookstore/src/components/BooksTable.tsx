import React, { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import axios from "axios";
import BookForm from "./BookForm";
import Confirmation from "./Confirmation";
import { Book } from "../types/Book";
import { Genre } from "../types/Genre";

const fetchBooks = async (): Promise<Book[]> => {
  const { data: books } = await axios.get<Book[]>(
    "http://localhost:3000/books"
  );
  const { data: genres } = await axios.get<Genre[]>(
    "http://localhost:3000/genres"
  );

  return books.map((book) => ({
    ...book,
    genre: genres.find((genre) => genre.id === book.genreId)?.name || "Unknown",
  }));
};

const BooksTable: React.FC = () => {
  const queryClient = useQueryClient();
  const {
    data: books,
    isLoading,
    isError,
  } = useQuery<Book[]>({
    queryKey: ["books"],
    queryFn: fetchBooks,
  });

  const deleteBookMutation = useMutation({
    mutationFn: (bookId: string) =>
      axios.delete(`http://localhost:3000/books/${bookId}`),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["books"] });
    },
  });

  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [isConfirmModalOpen, setIsConfirmModalOpen] = useState(false);
  const [currentBook, setCurrentBook] = useState<Book | undefined>(undefined);
  const [bookToDelete, setBookToDelete] = useState<string | null>(null);

  const handleEditClick = (book: Book) => {
    setCurrentBook(book);
    setIsEditModalOpen(true);
  };

  const handleDeleteClick = (bookId: string) => {
    setBookToDelete(bookId);
    setIsConfirmModalOpen(true);
  };

  const confirmDelete = () => {
    if (bookToDelete) {
      deleteBookMutation.mutate(bookToDelete);
    }
    setIsConfirmModalOpen(false);
    setBookToDelete(null);
  };

  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (isError) {
    return <div>Error loading books</div>;
  }

  return (
    <>
      <div className="mt-8 overflow-x-auto">
        <table className="min-w-full bg-stone-900 text-sm">
          <thead>
            <tr>
              <th className="w-1/4 p-4">Title</th>
              <th className="w-1/6 p-4">Author</th>
              <th className="w-1/12 p-4">Year</th>
              <th className="w-1/12 p-4">Copies</th>
              <th className="w-1/12 p-4">Price</th>
              <th className="w-1/6 p-4">Genre</th>
              <th className="w-1/12 p-4">Actions</th>
            </tr>
          </thead>
          <tbody>
            {books?.map((book: Book) => (
              <tr key={book.id}>
                <td className="border border-gray-700 px-4 py-2">
                  {book.title}
                </td>
                <td className="border border-gray-700 px-4 py-2">
                  {book.author}
                </td>
                <td className="border border-gray-700 px-4 py-2">
                  {book.year}
                </td>
                <td className="border border-gray-700 px-4 py-2">
                  {book.copies}
                </td>
                <td className="border border-gray-700 px-4 py-2">
                  {book.price.toFixed(2)} $
                </td>
                <td className="border border-gray-700 px-4 py-2">
                  {book.genre}
                </td>
                <td className="border border-gray-700 px-4 py-2">
                  <button
                    className="bg-gradient-to-b from-red-500 to-red-800 text-white px-4 py-2 w-full
                  hover:bg-gradient-to-b hover:from-red-700 hover:to-red-900 transition ease-in-out duration-300"
                    onClick={() => handleDeleteClick(book.id)}
                  >
                    Delete
                  </button>
                  <button
                    className="bg-gradient-to-b from-blue-800 to-blue-500 text-white px-4 py-2 w-full
                  hover:bg-gradient-to-b hover:from-blue-900 hover:to-blue-700 transition ease-in-out duration-300"
                    onClick={() => handleEditClick(book)}
                  >
                    Edit
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      {isEditModalOpen && (
        <BookForm
          onClose={() => setIsEditModalOpen(false)}
          initialData={currentBook}
        />
      )}
      {isConfirmModalOpen && (
        <Confirmation
          message="Are you sure you want to delete this book?"
          onConfirm={confirmDelete}
          onCancel={() => setIsConfirmModalOpen(false)}
        />
      )}
    </>
  );
};

export default BooksTable;
