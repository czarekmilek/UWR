import React from "react";

interface TodoItemProps {
  text: string;
  completed: boolean;
  onDelete: () => void;
  onToggle: () => void;
}

const TodoItem: React.FC<TodoItemProps> = ({
  text,
  completed,
  onDelete,
  onToggle,
}) => {
  return (
    <div className="todo-item-container">
      <div
        className={`todo-item ${completed ? "completed" : ""}`}
        onClick={onToggle}
      >
        <button className="delete-button" onClick={onDelete}>
          ⓧ
        </button>
        <span className="todo-text">{text}</span>
      </div>
    </div>
  );
};

export default TodoItem;
