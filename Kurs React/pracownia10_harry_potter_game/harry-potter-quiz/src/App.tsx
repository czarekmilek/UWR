import React, { useEffect, useState } from "react";
import { BeatLoader } from "react-spinners";
import axios from "axios";
import Game from "./Game";

const App: React.FC = () => {
  const [spells, setSpells] = useState([]);
  const [potions, setPotions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [category, setCategory] = useState<"spells" | "potions" | null>(null);

  useEffect(() => {
    const fetchSpells = async () => {
      try {
        const response = await axios.get("https://api.potterdb.com/v1/spells");
        setSpells(response.data.data);
      } catch (error) {
        setError("Error fetching spells");
      }
    };

    const fetchPotions = async () => {
      try {
        const response = await axios.get("https://api.potterdb.com/v1/potions");
        setPotions(response.data.data);
      } catch (error) {
        setError("Error fetching potions");
      }
    };

    const fetchData = async () => {
      await fetchSpells();
      await fetchPotions();
      setLoading(false);
    };

    fetchData();
  }, []);

  if (loading)
    return (
      <div className="flex flex-col items-center justify-center h-screen">
        <div className="text-center font-bold tracking-[0.2em] text-3xl mb-4">Loading...</div>
        <BeatLoader color="#4A90E2" size={15} />
      </div>
    );
  if (error)
    return (
      <div className="text-center font-bold tracking-[0.2em] mt-20 text-3xl text-red-600">
        {error}
      </div>
    );

  const handleCategorySelect = (selectedCategory: "spells" | "potions") => {
    setCategory(selectedCategory);
  };

  return (
    <div className="flex justify-center items-center h-screen">
      <div className="container mx-auto p-8">
        <h1 className="flex justify-center text-5xl font-bold mb-4 tracking-widest text-cyan-400">
          Harry Potter Guessing Game
        </h1>
        {category === null ? (
          <div>
            <h3 className="mt-8 flex justify-center tracking-wider text-3xl font-semibold mb-8 text-current">
              To start the quiz, choose a category, wizard 🧙‍♂️
            </h3>
            <div className="flex justify-center tracking-[0.2em] space-x-4">
              <button
                onClick={() => handleCategorySelect("spells")}
                className="m-4 px-16 py-8 text-xl bg-purple-600 text-white font-semibold 
            rounded-lg shadow-lg hover:bg-purple-700
            transition ease-in-out hover:translate-y-1 hover:scale-110 duration-500"
              >
                ⛧° Spells °⛧
              </button>
              <button
                onClick={() => handleCategorySelect("potions")}
                className="m-4 px-16 py-8 text-xl bg-emerald-600 text-white font-semibold 
            rounded-lg shadow-lg hover:bg-emerald-700
            transition ease-in-out hover:translate-y-1 hover:scale-110 duration-500"
              >
                ༺☠ Potions ☠༻
              </button>
            </div>
          </div>
        ) : (
          <div>
            {category === "spells" ? (
              <div className="mt-8 tracking-widest flex justify-center text-3xl font-semibold mb-8 text-current">
              <span className="text-cyan-500 font-semibold mr-2">Category:</span>{" "}
              <span className="text-white">⛧° Spells °⛧</span>
            </div>
            ) : (
                <div className="mt-8 tracking-widest flex justify-center text-3xl font-semibold mb-8 text-current">
                <span className="text-cyan-500 font-semibold mr-2">Category:</span>{" "}
                <span className="text-white">༺☠ Potions ☠༻</span>
              </div>
            )}
            <Game data={category === "spells" ? spells : potions} />
          </div>
        )}
      </div>
    </div>
  );
};

export default App;
