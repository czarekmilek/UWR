import React from "react";

interface TodoFiltersProps {
  onHideCompleted: () => void;
  showCompleted: boolean;
  onSearch: (searchTerm: string) => void;
  // v2 rzeczy
  onSortChange: (sortBy: "asc" | "desc" | "default") => void;
  onItemsPerPageChange: (count: number) => void;
  currentPage: number;
  totalPages: number;
  itemsPerPage: number;
  onPaginationChange: (pageNumber: number) => void;
  itemsPerPageOptions: number[];
  onCustomItemsPerPageChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

const TodoFilters: React.FC<TodoFiltersProps> = ({
  onHideCompleted,
  showCompleted,
  onSearch,
  onSortChange,
  onItemsPerPageChange,
  currentPage,
  totalPages,
  itemsPerPage,
  onPaginationChange,
  itemsPerPageOptions,
  onCustomItemsPerPageChange,
}) => {
  const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    onSearch(event.target.value);
  };

  const handleSortChange = (event: React.ChangeEvent<HTMLSelectElement>) => {
    const sortBy = event.target.value as "asc" | "desc" | "default";
    onSortChange(sortBy);
  };

  const handleItemsPerPageChange = (
    event: React.ChangeEvent<HTMLSelectElement>
  ) => {
    const count = parseInt(event.target.value);
    onItemsPerPageChange(count);
  };

  const handlePaginationChange = (pageNumber: number) => {
    onPaginationChange(pageNumber);
  };

  const renderPageNumber = () => {
    const pageNumbers = [];
    for (let i = 1; i <= totalPages; i++) {
      pageNumbers.push(
        <span
          key={i}
          className={i === currentPage ? "active" : ""}
          onClick={() => handlePaginationChange(i)}
        >
          {i === currentPage ? <strong>{" " + i + " "}</strong> : " " + i}
        </span>
      );
    }
    return pageNumbers;
  };

  return (
    <div className="todo-filters-container">
      {/* v2 rzeczy */}
      <div className="page-numbers">
        <p className="page-nums">{renderPageNumber()}</p>
        <div className="prev-next-buttons">
          <button
            disabled={currentPage === 1}
            onClick={() => handlePaginationChange(currentPage - 1)}
          >
            Prev
          </button>
          <button
            disabled={currentPage === totalPages}
            onClick={() => handlePaginationChange(currentPage + 1)}
          >
            Next
          </button>
        </div>

        <select onChange={handleSortChange}>
          <option value="default">Default</option>
          <option value="asc">A-Z</option>
          <option value="desc">Z-A</option>
        </select>

        {/* Domyślne opcje paginacji */}
        <select onChange={handleItemsPerPageChange}>
          {itemsPerPageOptions.map((count) => (
            <option key={count} value={count}>
              {count} per page
            </option>
          ))}
          {/* <option value="5">5 per page</option>
          <option value="10">10 per page</option>
          <option value="20">20 per page</option> */}
        </select>

        {/* Można zwiększać/zmniejszać paginację strzałkami UP/DOWn*/}
        <input
          className="custom-pagination-input"
          type="number"
          min="1"
          value={itemsPerPage}
          onChange={onCustomItemsPerPageChange}
        ></input>
      </div>
      <p>
        Click on the input above and use arrows for custom "items per page"
        amount
      </p>
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
