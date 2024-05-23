import { useContext } from 'react';
import { RecipeContext } from '../context/RecipeContext';

export function useRecipe() {
  const context = useContext(RecipeContext);
  if (!context) {
    throw new Error('useRecipe error');
  }
  return context;
}
