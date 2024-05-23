import React from 'react';
import { useState } from 'react';
import './App.css';
import RecipeContext from './context/RecipeContext';
import RecipeCreator from './components/RecipeCreator';
import RecipeFilter from './components/RecipeFilter';
import RecipeList from './components/RecipeList';

export default function App() {
  const [searchTerm, setSearchTerm] = useState('');
  const [filterFav, setFilterFav] = useState(false);

  return (
    <div className="App">
      <RecipeContext>
        <RecipeCreator />
        <RecipeFilter
          toggleFav={() => setFilterFav(!filterFav)}
          visibilityFav={filterFav}
          setSearchTerm={setSearchTerm}
          searchTerm={searchTerm}
        />
        <RecipeList onlyFav={filterFav} filterTerm={searchTerm} />
      </RecipeContext>
    </div>
  );
}
