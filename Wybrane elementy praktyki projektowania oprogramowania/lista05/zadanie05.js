const http = require('http');
const https = require('https');

function fetchData(url) {
  return new Promise((resolve, reject) => {
    // Wybór modułu HTTP lub HTTPS w zależności od protokołu
    const client = url.startsWith('https') ? https : http;

    const request = client.get(url, (response) => {
      let data = '';

      // Zdarzenie 'data': rejestruj dane
      response.on('data', (chunk) => {
        data += chunk;
      });

      // Zdarzenie 'end': rejestruj zakończenie odbioru danych
      response.on('end', () => {
        resolve(data);
      });
    });

    // Zdarzenie 'error': rejestruj błędy
    request.on('error', (error) => {
      reject(error);
    });
  });
}

const url = 'https://uwr.edu.pl/stypendia-i-wsparcie-finansowe/ubezpieczenie-nnw-i-oc-2/'; 

// Wywołanie funkcji i obsługa Promise
fetchData(url)
  .then((data) => {
    console.log('Zawartość zasobu:', data);
  })
  .catch((error) => {
    console.error('Błąd:', error.message);
  });
