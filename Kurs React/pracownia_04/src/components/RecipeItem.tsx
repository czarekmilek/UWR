import { Recipe } from '../context/Recipe.type';
import { useRecipe } from '../hooks/recipeHooks';

interface Props {
  recipe: Recipe;
}

export default function RecipeItem({ recipe }: Props) {
  const { deleteRecipe, toggleFav } = useRecipe();

  const handleDelete = () => {
    deleteRecipe(recipe.id);
  };

  const handleToggleFav = () => {
    toggleFav(recipe.id);
  };

  const renderedSteps = recipe.steps.map((step, index) => (
    <div key={index}>
      <span>{`${index + 1}. `}</span>
      <span>{step}</span>
    </div>
  ));

  const renderedIngredients = recipe.ingredients.map((ingredient, index) => (
    <div key={index}>
      <span>{`▪ `}</span>
      <span>{ingredient}</span>
    </div>
  ));

  return (
    <div className="recipe-item" key={recipe.id}>
      <h3>{recipe.name}</h3>
      <div className="ingredients">{renderedIngredients}</div>
      <div className="steps">{renderedSteps}</div>
      <button onClick={handleDelete}>Delete</button>
      <button onClick={handleToggleFav}>
        {recipe.fav ? 'Favorites ☑' : 'Favorites ☐'}
      </button>
    </div>
  );
}
