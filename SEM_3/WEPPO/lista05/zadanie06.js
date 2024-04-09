const fs = require('fs');
const readline = require('readline');

const filePath = 'przykladowe_logi.txt';

const clientRequestsCount = new Map();

// Odczytuje plik
const rl = readline.createInterface({
  input: fs.createReadStream(filePath),
  crlfDelay: Infinity, // Każda linia to nowe zdarzenie
});

rl.on('line', (line) => {
  const [, clientIP] = line.split(' ', 2); // Wyciąga IP
  const count = clientRequestsCount.get(clientIP) || 0; // Zlicza ilość żądań
  clientRequestsCount.set(clientIP, count + 1);
});

rl.on('close', () => {
    // Sortuje wyniki i wybiera 3 największe
  const sortedClients = [...clientRequestsCount.entries()].sort((a, b) => b[1] - a[1]).slice(0, 3);

  console.log('Top 3:');
  for (const [clientIP, count] of sortedClients) {
    console.log(`${clientIP} ${count}`);
  }
});