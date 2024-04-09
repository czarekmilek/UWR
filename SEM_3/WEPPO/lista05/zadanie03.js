const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Losowanie liczby od 0 do 100
const targetNumber = Math.floor(Math.random() * 101);

function startGuessingGame() {
  // Zapytanie o podanie liczby
  rl.question('Zgadnij liczbę od 0 do 100: ', (userGuess) => {
    const guess = parseInt(userGuess, 10);

    // console.log(targetNumber)

    // Sprawdzenie warunków
    if (isNaN(guess)) {
      console.log('To nie jest liczba. Spróbuj ponownie.');
      startGuessingGame();
    } else if (guess === targetNumber) {
      console.log(`Brawo! To jest właśnie ta liczba - ${targetNumber}`);
      rl.close();
    } else if (guess < targetNumber) {
      console.log('Moja liczba jest większa. Spróbuj ponownie.');
      startGuessingGame();
    } else {
      console.log('Moja liczba jest mniejsza. Spróbuj ponownie.');
      startGuessingGame();
    }
  });
}

// Rozpoczęcie gry
startGuessingGame();
