import { createContext, useReducer } from 'react';
import { Recipe } from '../context/Recipe.type';

type RecipeAction =
  | {
      type: 'ADD';
      payload: {
        name: string;
        ingredients: string[];
        steps: string[];
      };
    }
  | {
      type: 'REMOVE';
      payload: {
        id: number;
      };
    }
  | {
      type: 'TOGGLE_FAVOURITE';
      payload: {
        id: number;
      };
    };

export const recipeReducer = (state: Recipe[], action: RecipeAction) => {
  switch (action.type) {
    case 'ADD':
      const newRecipe: Recipe = {
        id: Date.now(),
        name: action.payload.name,
        ingredients: action.payload.ingredients,
        steps: action.payload.steps,
        fav: false,
      };
      return [...state, newRecipe];
    case 'REMOVE':
      return state.filter((recipe) => recipe.id !== action.payload.id);
    case 'TOGGLE_FAVOURITE':
      return state.map((recipe) =>
        recipe.id !== action.payload.id
          ? recipe
          : { ...recipe, fav: !recipe.fav }
      );
    default:
      return state;
  }
};

export const RecipeContext = createContext<{
  recipes: Recipe[];
  addRecipe: (name: string, ingredients: string[], steps: string[]) => void;
  deleteRecipe: (id: number) => void;
  toggleFav: (id: number) => void;
}>({
  recipes: [],
  addRecipe: () => {},
  deleteRecipe: () => {},
  toggleFav: () => {},
});

const initialRecipes: Recipe[] = [
  {
    id: 1,
    name: 'Tosty z serem',
    ingredients: ['Chleb (dowolny)', 'Ser'],
    steps: [
      'Połóż kromkę chleba w tosterze',
      'Połóż kawałek sera na kromce',
      'Połóż kolejną kromkę na ser',
      'Zamknij toster i poczekaj chwilę',
    ],
    fav: false,
  },
  {
    id: 2,
    name: 'Płatki na mleku',
    ingredients: ['Płatki', 'Mleko'],
    steps: ['Wsyp płatki do miski', 'Zalej mlekiem'],
    fav: false,
  },
  {
    id: 3,
    name: 'Tortilla z mięsem',
    ingredients: ['Dowolne mięso', 'Tortilla', 'Warzywa'],
    steps: [
      'Wrzuć mięso na grilla',
      'Jednocześnie przygotuj warzywa, w dowolny sposób',
      'Wrzuć tortillę na chwilę do opiekacza, aby była cieplutka',
      'Po usmażeniu mięsa i przygotowaniu warzyw wrzuć je na ciepłą tortillę',
      'Zawiń tortillę w dowolny sposób',
    ],
    fav: false,
  },
];

const RecipeProvider = ({ children }: { children: React.ReactNode }) => {
  const [recipes, dispatchRecipe] = useReducer(recipeReducer, initialRecipes);

  function addRecipe(name: string, ingredients: string[], steps: string[]) {
    dispatchRecipe({ type: 'ADD', payload: { name, ingredients, steps } });
  }

  function deleteRecipe(id: number) {
    dispatchRecipe({ type: 'REMOVE', payload: { id } });
  }

  function toggleFav(id: number) {
    dispatchRecipe({ type: 'TOGGLE_FAVOURITE', payload: { id } });
  }

  return (
    <RecipeContext.Provider
      value={{ recipes, addRecipe, deleteRecipe, toggleFav }}
    >
      {children}
    </RecipeContext.Provider>
  );
};

export default RecipeProvider;
