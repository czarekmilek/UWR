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

const testAddingBooks = (testCases) => {
  testCases.forEach(({ testCase, shouldFail }, index) => {
    try {
      addBookToLibrary(...testCase);
      if (shouldFail) {
        console.log(
          `Test ${
            index + 1
          } failed: Oczekiwano błędu, ale operacja zakończyła się sukcesem. TestCase: ${JSON.stringify(
            testCase
          )}`
        );
      } else {
        console.log(`Test ${index + 1} passed.`);
      }
    } catch (error) {
      if (shouldFail) {
        console.log(
          `Test ${index + 1} passed: Wyrzucono oczekiwany błąd ("${
            error.message
          }"). TestCase: ${JSON.stringify(testCase)}`
        );
      } else {
        console.log(
          `Test ${index + 1} failed: Nieoczekiwany błąd ("${
            error.message
          }"). TestCase: ${JSON.stringify(testCase)}`
        );
      }
    }
  });
};

const testCases = [
  { testCase: ["", "Author", 200, true, []], shouldFail: true },
  { testCase: ["Title", "", 200, true, []], shouldFail: true },
  { testCase: ["Title", "Author", -1, true, []], shouldFail: true },
  { testCase: ["Title", "Author", 200, "yes", []], shouldFail: true },
  { testCase: ["Title", "Author", 200, true, [1, 2, 3, 6]], shouldFail: true },
  {
    testCase: ["Title", "Author", 200, true, [1, 2, 3, "yes"]],
    shouldFail: true,
  },
  { testCase: ["Title", "Author", 200, true, [1, 2, 3, {}]], shouldFail: true },
  { testCase: ["Title", "Author", 200, true, []], shouldFail: false },
  { testCase: ["Title", "Author", 200, true, [1, 2, 3]], shouldFail: false },
  { testCase: ["Title", "Author", 200, true, [1, 2, 3, 4]], shouldFail: false },
  {
    testCase: ["Title", "Author", 200, true, [1, 2, 3, 4, 5]],
    shouldFail: false,
  },
  {
    testCase: ["Title", "Author", 200, true, [1, 2, 3, 4, 5]],
    shouldFail: false,
  },
];

testAddingBooks(testCases);
