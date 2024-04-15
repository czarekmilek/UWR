import React from "react";

interface TodoFiltersProps {
  onHideCompleted: () => void;
  showCompleted: boolean;
  onSearch: (searchTerm: string) => void;
}

const TodoFilters: React.FC<TodoFiltersProps> = ({
  onHideCompleted,
  showCompleted,
  onSearch,
}) => {
  const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    onSearch(event.target.value);
  };
  return (
    <div className="todo-filters-container">
      <input
        className="todo-input"
        type="text"
        placeholder="Search tasks..."
        onChange={handleSearchChange}
      />
      <button className="todo-input-button" onClick={onHideCompleted}>
        {showCompleted ? "Hide Completed Tasks" : "Show Completed Tasks"}
      </button>
    </div>
  );
};

export default TodoFilters;
