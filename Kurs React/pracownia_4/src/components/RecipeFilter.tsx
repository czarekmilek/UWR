import React from 'react';

interface Props {
  toggleFav: () => void;
  visibilityFav: boolean;
  searchTerm: string;
  setSearchTerm: (searchTerm: string) => void;
}

export default function RecipeFilter({
  toggleFav,
  visibilityFav,
  searchTerm,
  setSearchTerm,
}: Props) {
  const handleSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const newTerm = e.target.value;
    setSearchTerm(newTerm);
  };

  const handleToggleFav = () => {
    toggleFav();
  };

  return (
    <div className="filter-recipe">
      <input
        type="text"
        placeholder="Search..."
        value={searchTerm}
        onChange={handleSearchChange}
      />
      <button onClick={handleToggleFav}>
        {visibilityFav ? 'Show All' : 'Show Favorites'}
      </button>
    </div>
  );
}
