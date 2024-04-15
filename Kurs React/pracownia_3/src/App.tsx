import React, { useState } from "react";
import TodoInput from "./components/TodoInput";
import TodoFilters from "./components/TodoFilters";
import TodoList from "./components/TodoList";
import "./styles.css";

const App: React.FC = () => {
  const [todos, setTodos] = useState<any[]>([]);
  const [showCompleted, setShowCompleted] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");

  // v2 rzeczy
  const [sortBy, setSortBy] = useState<"asc" | "desc" | "default">("default");
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(5);

  const handleAddTodo = (text: string) => {
    const newTodo = {
      id: Date.now(),
      text: text,
      completed: false,
    };
    setTodos((prevTodos) => [...prevTodos, newTodo]);
  };

  const handleDeleteTodo = (id: number) => {
    setTodos((prevTodos) => prevTodos.filter((todo) => todo.id !== id));
  };

  const handleToggleTodo = (id: number) => {
    setTodos((prevTodos) =>
      prevTodos.map((todo) =>
        todo.id === id ? { ...todo, completed: !todo.completed } : todo
      )
    );
  };

  const handleToggleCompleted = () => {
    setShowCompleted((prevShowCompleted) => !prevShowCompleted);
  };

  const handleSearch = (searchTerm: string) => {
    setSearchTerm(searchTerm);
  };

  const filteredTodos = todos.filter((todo) => {
    return (
      todo.text.toLowerCase().includes(searchTerm.toLowerCase()) &&
      (showCompleted || !todo.completed)
    );
  });

  // v2 rzeczy
  const handleSortChange = (sortBy: "asc" | "desc" | "default") => {
    setSortBy(sortBy);
  };

  const handlePageChange = (pageNumber: number) => {
    setCurrentPage(pageNumber);
  };

  const handleItemsPerPageChange = (count: number) => {
    setItemsPerPage(count);
  };

  const handleCustomItemsPerPageChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    const count = parseInt(e.target.value);
    if (!isNaN(count) && count > 0) {
      setItemsPerPage(count);
    }
  };

  // Sortowanie zadań
  if (sortBy === "asc") {
    filteredTodos.sort((a, b) => a.text.localeCompare(b.text));
  } else if (sortBy === "desc") {
    filteredTodos.sort((a, b) => b.text.localeCompare(a.text));
  }

  // Paginacja
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentTodos = filteredTodos.slice(indexOfFirstItem, indexOfLastItem);

  return (
    <div className="app">
      <h1>ToDo List</h1>
      <TodoInput onAdd={handleAddTodo} />
      <TodoList
        todos={currentTodos}
        onDelete={handleDeleteTodo}
        onToggle={handleToggleTodo}
      />
      <TodoFilters
        onHideCompleted={handleToggleCompleted}
        showCompleted={showCompleted}
        onSearch={handleSearch}
        onSortChange={handleSortChange}
        onItemsPerPageChange={handleItemsPerPageChange}
        currentPage={currentPage}
        totalPages={Math.ceil(filteredTodos.length / itemsPerPage)}
        itemsPerPage={itemsPerPage}
        onPaginationChange={handlePageChange}
        itemsPerPageOptions={[5, 10, 20]}
        onCustomItemsPerPageChange={handleCustomItemsPerPageChange}
      />
    </div>
  );
};

export default App;
