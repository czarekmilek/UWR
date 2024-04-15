import React, { useState } from "react";
import TodoInput from "./components/TodoInput";
import TodoFilters from "./components/TodoFilters";
import TodoList from "./components/TodoList";
import "./styles.css";

const App: React.FC = () => {
  const [todos, setTodos] = useState<any[]>([]);
  const [showCompleted, setShowCompleted] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");

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

  return (
    <div className="app">
      <h1>ToDo List</h1>
      <TodoInput onAdd={handleAddTodo} />
      <TodoList
        todos={filteredTodos}
        onDelete={handleDeleteTodo}
        onToggle={handleToggleTodo}
      />
      <TodoFilters
        onHideCompleted={handleToggleCompleted}
        showCompleted={showCompleted}
        onSearch={handleSearch}
      />
    </div>
  );
};

export default App;
