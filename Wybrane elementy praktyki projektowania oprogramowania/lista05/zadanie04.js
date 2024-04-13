const fs = require('fs');

const filePath = 'zad4.txt'; // Zastąp 'nazwa_pliku.txt' właściwą nazwą pliku

// Funkcja zwrotna do obsługi odczytu pliku
function handle_reading(error, data) {
  if (error) {
    console.error('Błąd odczytu pliku:', error.message);
  } else {
    console.log('Zawartość pliku:\n', data);
  }
}

// Odczyt pliku tekstowego
fs.readFile(filePath, 'utf8', handle_reading);
