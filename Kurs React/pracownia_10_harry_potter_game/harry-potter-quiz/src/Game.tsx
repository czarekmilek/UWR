import React, { useState } from "react";

interface GameProps {
  data: Array<{ id: string; attributes: { name: string; effect: string } }>;
}

const Game: React.FC<GameProps> = ({ data }) => {
  const [score, setScore] = useState(0);
  const [highScore, setHighScore] = useState<number>(
    parseInt(localStorage.getItem("highScore") || "0", 10)
  );
  const [currentQuestion, setCurrentQuestion] = useState(getRandomQuestion());
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [feedback, setFeedback] = useState<string | null>(null);
  const [disabledAnswers, setDisabledAnswers] = useState<Set<string>>(
    new Set()
  );

  function getRandomQuestion() {
    const correctAnswer = data[Math.floor(Math.random() * data.length)];
    const wrongAnswers = data
      .filter((item) => item.id !== correctAnswer.id)
      .sort(() => 0.5 - Math.random())
      .slice(0, 3);
    return {
      question: correctAnswer.attributes.effect,
      answers: [correctAnswer, ...wrongAnswers].sort(() => 0.5 - Math.random()),
      correctAnswer: correctAnswer.attributes.name,
    };
  }

  const handleAnswerClick = (answer: string) => {
    setSelectedAnswer(answer);
    if (answer === currentQuestion.correctAnswer) {
      setFeedback("Correct! You're a wizard!");
      const newScore = score + 1;
      setScore(newScore);
      if (newScore > highScore) {
        setHighScore(newScore);
        localStorage.setItem("highScore", newScore.toString());
      }
      setTimeout(() => {
        setCurrentQuestion(getRandomQuestion());
        setSelectedAnswer(null);
        setFeedback(null);
        setDisabledAnswers(new Set());
      }, 1000);
    } else {
      setFeedback("Incorrect! You're not a wizard. But try again.");
      setScore(0);
      setDisabledAnswers(new Set(disabledAnswers).add(answer));
    }
  };

  const handleResetHighScore = () => {
    setHighScore(0);
    localStorage.setItem("highScore", "0");
  };

  return (
    <div className="bg-indigo-950 tracking-[0.2em] text-white p-6 rounded-lg shadow-lg">
      <div className="flex justify-center space-x-4">
        {feedback && <div className="mt-2 absolute text-indigo-300">{feedback}</div>}
      </div>
      <div className="mb-4">
        <div className="text-xl mb-2">
          <span className="text-yellow-400 font-semibold">Score:</span>{" "}
          <span className="text-white">{score}</span>
        </div>
        <div className="text-xl mb-2">
          <span className="text-orange-400 font-semibold">High Score:</span>{" "}
          <span className="text-white">{highScore}</span>
        </div>
        <div className="text-xl mb-8 text-center">
          {currentQuestion.question}
        </div>
        <div className="grid grid-cols-2 gap-4">
          {currentQuestion.answers.map((answer, index) => (
            <button
              key={index}
              onClick={() => handleAnswerClick(answer.attributes.name)}
              className={`p-4 rounded-lg shadow-md hover:shadow-lg transition ${
                selectedAnswer === answer.attributes.name
                  ? selectedAnswer === currentQuestion.correctAnswer
                    ? "bg-emerald-800 font-semibold text-white"
                    : "bg-rose-800 font-semibold text-white"
                  : disabledAnswers.has(answer.attributes.name)
                  ? "bg-gray-700 font-semibold text-white cursor-not-allowed"
                  : "bg-indigo-700 font-semibold hover:bg-indigo-900 shadow-lg transition ease-in-out hover:-translate-y-1 hover:scale-[101%] duration-300"
              }`}
              disabled={disabledAnswers.has(answer.attributes.name)}
            >
              {answer.attributes.name}
            </button>
          ))}
        </div>
      </div>
      <div className="flex justify-center space-x-4">
        <button
          onClick={() => window.location.reload()}
          className="w-52 mt-4 p-3 bg-cyan-700 text-white rounded-lg hover:bg-cyan-800
        shadow-lg transition ease-in-out hover:-translate-y-1 hover:scale-105 duration-300"
        >
          Select Category
        </button>
        <button
          onClick={handleResetHighScore}
          className="w-52 mt-4 p-3 bg-rose-700 text-white rounded-lg hover:bg-rose-800
        shadow-lg transition ease-in-out hover:-translate-y-1 hover:scale-105 duration-300"
        >
          Reset High Score
        </button>
      </div>
    </div>
  );
};

export default Game;
