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
