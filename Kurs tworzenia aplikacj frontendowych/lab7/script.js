document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("add-todo-form");
  const input = form.querySelector('input[name="todo-name"]');
  const todoListEl = document.getElementById("todo-list");
  const countEl = document.getElementById("count");
  const clearBtn = document.getElementById("todos-clear");

  // Nasz stan – tablica obiektów { name: string, completed: boolean }
  let todos = [];

  function init() {
    const existing = Array.from(todoListEl.children);
    existing.forEach((li) => {
      const name = li.querySelector(".todo-name").textContent.trim();
      const completed = li.classList.contains("todo__container--completed");
      todos.push({ name, completed });
    });
    render();
  }

  function render() {
    todoListEl.innerHTML = "";

    todos.forEach((todo, i) => {
      const li = document.createElement("li");
      li.classList.add("todo__container");
      if (todo.completed) li.classList.add("todo__container--completed");

      // nazwa zadania
      const nameDiv = document.createElement("div");
      nameDiv.classList.add("todo-element", "todo-name");
      nameDiv.textContent = todo.name;
      li.appendChild(nameDiv);

      // przycisk „Move up”
      const upBtn = document.createElement("button");
      upBtn.classList.add("todo-element", "todo-button", "move-up");
      upBtn.textContent = "↑";
      upBtn.addEventListener("click", () => moveUp(i));
      li.appendChild(upBtn);

      // przycisk „Move down”
      const downBtn = document.createElement("button");
      downBtn.classList.add("todo-element", "todo-button", "move-down");
      downBtn.textContent = "↓";
      downBtn.addEventListener("click", () => moveDown(i));
      li.appendChild(downBtn);

      // przycisk „Done” lub „Revert”
      const toggleBtn = document.createElement("button");
      toggleBtn.classList.add("todo-element", "todo-button");
      toggleBtn.textContent = todo.completed ? "Revert" : "Done";
      toggleBtn.addEventListener("click", () => toggleComplete(i));
      li.appendChild(toggleBtn);

      // przycisk „Remove”
      const removeBtn = document.createElement("button");
      removeBtn.classList.add("todo-element", "todo-button");
      removeBtn.textContent = "Remove";
      removeBtn.addEventListener("click", () => removeTodo(i));
      li.appendChild(removeBtn);

      todoListEl.appendChild(li);
    });

    updateCount();
  }

  function addTodo(name) {
    todos.push({ name, completed: false });
    render();
  }
  function removeTodo(idx) {
    todos.splice(idx, 1);
    render();
  }
  function toggleComplete(idx) {
    todos[idx].completed = !todos[idx].completed;
    render();
  }
  function moveUp(idx) {
    if (idx === 0) return;
    [todos[idx - 1], todos[idx]] = [todos[idx], todos[idx - 1]];
    render();
  }
  function moveDown(idx) {
    if (idx === todos.length - 1) return;
    [todos[idx], todos[idx + 1]] = [todos[idx + 1], todos[idx]];
    render();
  }
  function clearAll() {
    todos = [];
    render();
  }

  function updateCount() {
    const remaining = todos.filter((t) => !t.completed).length;
    countEl.textContent = remaining;
  }

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const text = input.value.trim();
    if (text) {
      addTodo(text);
      input.value = "";
    }
  });
  clearBtn.addEventListener("click", clearAll);

  init();
});
