import { useState } from 'react';
import { useRecipe } from '../hooks/recipeHooks';

export default function AddRecipe() {
  const { addRecipe } = useRecipe();
  const [name, setName] = useState('');
  const [ingredients, setIngredients] = useState<string[]>([]);
  const [steps, setSteps] = useState<string[]>([]);
  const [error, setError] = useState(false);

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (name.trim() === '' || ingredients.length <= 0 || steps.length <= 0) {
      setError(true);
      return;
    }
    addRecipe(
      name,
      ingredients.filter((i) => i.trim() !== '').map((i) => i.trim()),
      steps.filter((i) => i.trim() !== '').map((i) => i.trim())
    );
    setName('');
    setIngredients([]);
    setSteps([]);
    setError(false);
  };

  const handleNameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setName(e.target.value);
  };

  const handleIngredientsChange = (
    e: React.ChangeEvent<HTMLTextAreaElement>
  ) => {
    setIngredients(e.target.value.split('\n'));
  };

  const handleStepsChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setSteps(e.target.value.split('\n'));
  };

  return (
    <div className="add-recipe">
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Name"
          value={name}
          onChange={handleNameChange}
        />
        <textarea
          className="ingredients"
          placeholder="Ingredients"
          value={ingredients.join('\n')}
          onChange={handleIngredientsChange}
        />
        <textarea
          className="steps"
          placeholder="Steps"
          value={steps.join('\n')}
          onChange={handleStepsChange}
        />
        <button type="submit">Add Recipe</button>
        {error && (
          <p className="error">Please fill every field in form above</p>
        )}
      </form>
    </div>
  );
}
