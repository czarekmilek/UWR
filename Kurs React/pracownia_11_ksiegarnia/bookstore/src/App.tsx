import React, { useState } from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import Header from "./components/Header";
import BooksTable from "./components/BooksTable";
import BookForm from "./components/BookForm";

const queryClient = new QueryClient();

const App: React.FC = () => {
  const [isBookFormOpen, setIsBookFormOpen] = useState(false);

  return (
    <QueryClientProvider client={queryClient}>
      <Header />
      <main className="p-4 mt-16">
        <div className="flex justify-center mb-4">
          <button
            className="bg-gradient-to-b from-green-500 to-green-900 
          text-white-700 px-4 py-2 rounded text-xl tracking-wider 
          hover:bg-gradient-to-b hover:from-green-700 hover:to-green-900 
          transition ease-in-out hover:translate-y-0.5 hover:scale-110 duration-300"
            onClick={() => setIsBookFormOpen(true)}
          >
            Add Book
          </button>
        </div>
        <BooksTable />
        {isBookFormOpen && (
          <BookForm onClose={() => setIsBookFormOpen(false)} />
        )}
      </main>
    </QueryClientProvider>
  );
};

export default App;
