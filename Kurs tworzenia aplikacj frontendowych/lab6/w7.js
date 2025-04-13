let library = [];

const addBookToLibrary = (title, author, pages, isAvailable, ratings) => {
  if (typeof title !== "string" || title.trim() === "") {
    throw new Error("Invalid title");
  }
  if (typeof author !== "string" || author.trim() === "") {
    throw new Error("Invalid author");
  }
  if (typeof pages !== "number" || pages <= 0) {
    throw new Error("Invalid pages");
  }
  if (typeof isAvailable !== "boolean") {
    throw new Error("Invalid availability");
  }
  if (!Array.isArray(ratings)) {
    throw new Error("Ratings must be an array");
  }
  if (
    !ratings.every((num) => typeof num === "number" && num >= 0 && num <= 5)
  ) {
    throw new Error("Ratings must be numbers between 0 and 5");
  }

  library.push({
    title,
    author,
    pages,
    available: isAvailable,
    ratings,
  });
};

const addBooksToLibrary = (booksArgsArray) => {
  booksArgsArray.forEach((bookArgs) => {
    addBookToLibrary(...bookArgs);
  });
};

const books = [
  ["Alice in Wonderland", "Lewis Carroll", 200, true, [1, 2, 3]],
  ["1984", "George Orwell", 300, true, [4, 5]],
  ["The Great Gatsby", "F. Scott Fitzgerald", 150, true, [3, 4]],
  ["To Kill a Mockingbird", "Harper Lee", 250, true, [2, 3]],
  ["The Catcher in the Rye", "J.D. Salinger", 200, true, [1, 2]],
  ["The Hobbit", "J.R.R. Tolkien", 300, true, [4, 5]],
  ["Fahrenheit 451", "Ray Bradbury", 200, true, [3, 4]],
  ["Brave New World", "Aldous Huxley", 250, true, [2, 3]],
  ["The Alchemist", "Paulo Coelho", 200, true, [1, 2]],
  ["The Picture of Dorian Gray", "Oscar Wilde", 300, true, [4, 5]],
];

addBooksToLibrary(books);
console.log(library);
