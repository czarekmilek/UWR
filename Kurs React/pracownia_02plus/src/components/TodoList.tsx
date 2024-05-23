import React from "react";
import TodoItem from "./TodoItem";

interface Todo {
  id: number;
  text: string;
  completed: boolean;
}

interface TodoListProps {
  todos: Todo[];
  onDelete: (id: number) => void;
  onToggle: (id: number) => void;
}

const TodoList: React.FC<TodoListProps> = ({ todos, onDelete, onToggle }) => {
  return (
    <div className="todo-list">
      {todos.map((todo) => (
        <TodoItem
          key={todo.id}
          text={todo.text}
          completed={todo.completed}
          onDelete={() => onDelete(todo.id)}
          onToggle={() => onToggle(todo.id)}
        />
      ))}
    </div>
  );
};

export default TodoList;
