import React, { useState } from "react";

interface TodoInputProps {
  onAdd: (text: string) => void;
}

const TodoInput: React.FC<TodoInputProps> = ({ onAdd }) => {
  const [text, setText] = useState("");

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setText(event.target.value);
  };

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (text.trim() !== "") {
      onAdd(text);
      setText("");
    }
  };

  return (
    <div className="todo-input-container">
      <form className="todo-form" onSubmit={handleSubmit}>
        <input
          className="todo-input"
          type="text"
          placeholder="Enter task..."
          value={text}
          onChange={handleChange}
        />
        <button className="todo-input-button" type="submit">
          Add
        </button>
      </form>
    </div>
  );
};

export default TodoInput;
