import RecipeItem from './RecipeItem';
import { Recipe } from '../context/Recipe.type';
import { useRecipe } from '../hooks/recipeHooks';

interface Props {
  onlyFav: boolean;
  filterTerm: string;
}

export default function RecipeList({ onlyFav, filterTerm }: Props) {
  const { recipes } = useRecipe();

  const filterRecipes = (recipe: Recipe) => {
    const filterLower = filterTerm.toLowerCase();
    const includesFilter = (item: string) =>
      item.toLowerCase().includes(filterLower);

    const isFav = !onlyFav || recipe.fav;

    return (
      isFav &&
      (includesFilter(recipe.name) ||
        recipe.ingredients.some(includesFilter) ||
        recipe.steps.some(includesFilter))
    );
  };

  return (
    <div className="recipe-list">
      {recipes.filter(filterRecipes).map((recipe) => (
        <RecipeItem recipe={recipe} key={recipe.id} />
      ))}
    </div>
  );
}
