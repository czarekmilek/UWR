const fs = require('fs');

function readFileCallback(filePath, callback) {
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      callback(err, null);
    } else {
      callback(null, data);
    }
  });
}

// Użycie
readFileCallback('loremipsum.txt', (err, data) => {
  if (err) {
    console.error(err);
  } else {
    console.log(data);
  }
});

//////////////////////////////////////////////

const util = require('util');
const readFilePromise = util.promisify(fs.readFile);

// Użycie
readFilePromise('loremipsum.txt', 'utf8')
  .then((data) => console.log(data))
  .catch((err) => console.error(err));

//////////////////////////////////////////////

const { readFile } = require('fs').promises;

// Użycie
readFile('loremipsum.txt', 'utf8')
  .then((data) => console.log(data))
  .catch((err) => console.error(err));

//////////////////////////////////////////////

readFilePromise('loremipsum.txt', 'utf8')
.then((data) => {
console.log('Using .then:', data);
})
.catch((err) => console.error(err));

//////////////////////////////////////////////

async function readAndLogFile() {
    try {
      const data = await readFilePromise('loremipsum.txt', 'utf8');
      console.log('Using async/await:', data);
    } catch (err) {
      console.error(err);
    }
  }
  
readAndLogFile();
  