/**
 * @typedef {Object} Product
 * @property {number} id - Unikalny ID produktu.
 * @property {string} name - Nazwa produktu.
 * @property {number} quantity - Liczba sztuk do zakupu.
 * @property {Date} date - Data, do której produkt powinien być zakupiony.
 * @property {boolean} purchased - Status, czy produkt został zakupiony.
 * @property {number} [price] - Cena za sztukę.
 */

/**
 * Tablica z listą produktów.
 * @type {Product[]}
 */
let shoppingList = [];

/**
 * Generuje unikalne ID.
 * @returns {number} Losowa liczba jako id.
 */
function generateId() {
  return Math.floor(Math.random() * 1e8);
}

/**
 * Dodaje nowy produkt do listy zakupów.
 * @param {string} name - Nazwa produktu.
 * @param {number} quantity - Liczba sztuk.
 * @param {string} dateStr - Data zakupu w postaci stringa.
 */
function addProduct(name, quantity, dateStr) {
  const newProduct = {
    id: generateId(),
    name: name,
    quantity: quantity,
    date: new Date(dateStr),
    purchased: false,
  };
  shoppingList.push(newProduct);
}

/**
 * Usuwa produkt z listy na podstawie podanego ID.
 * @param {number} id - ID produktu do usunięcia.
 */
function removeProduct(id) {
  shoppingList = shoppingList.filter((product) => product.id !== id);
}

/**
 * Edytuje nazwę produktu na podstawie ID.
 * @param {number} id - ID produktu.
 * @param {string} newName - Nowa nazwa produktu.
 */
function editProductName(id, newName) {
  const product = shoppingList.find((product) => product.id === id);
  if (product) {
    product.name = newName;
  }
}

/**
 * Edytuje status zakupienia produktu na podstawie ID.
 * @param {number} id - ID produktu.
 * @param {boolean} newStatus - Nowy status (true jeśli zakupiony, false jeśli nie).
 */
function editProductStatus(id, newStatus) {
  const product = shoppingList.find((product) => product.id === id);
  if (product) {
    product.purchased = newStatus;
  }
}

/**
 * Edytuje liczbę sztuk produktu na podstawie ID.
 * @param {number} id - ID produktu.
 * @param {number} newQuantity - Nowa liczba sztuk.
 */
function editProductQuantity(id, newQuantity) {
  const product = shoppingList.find((product) => product.id === id);
  if (product) {
    product.quantity = newQuantity;
  }
}

/**
 * Edytuje datę zakupu produktu na podstawie ID.
 * @param {number} id - ID produktu.
 * @param {string} newDateStr - Nowa data zakupu w formacie string.
 */
function editProductDate(id, newDateStr) {
  const product = shoppingList.find((product) => product.id === id);
  if (product) {
    product.date = new Date(newDateStr);
  }
}

/**
 * Zamienia miejscami dwa produkty w liście.
 * @param {number} id1 - ID pierwszego produktu.
 * @param {number} id2 - ID drugiego produktu.
 */
function swapProducts(id1, id2) {
  const index1 = shoppingList.findIndex((product) => product.id === id1);
  const index2 = shoppingList.findIndex((product) => product.id === id2);
  if (index1 !== -1 && index2 !== -1) {
    const temp = shoppingList[index1];
    shoppingList[index1] = shoppingList[index2];
    shoppingList[index2] = temp;
  }
}

/**
 * Zwraca listę produktów, które powinny być zakupione dzisiaj.
 * @returns {Product[]} Lista produktów do zakupu dzisiaj.
 */
function getTodayProducts() {
  const todayStr = new Date().toDateString();
  return shoppingList.filter(
    (product) => !product.purchased && product.date.toDateString() === todayStr
  );
}

/**
 * Ustawia cenę za sztukę dla zakupionego produktu.
 * Jeśli produkt nie jest zakupiony, nie dokonuje zmiany.
 * @param {number} id - ID produktu.
 * @param {number} price - Cena za sztukę.
 */
function setProductPrice(id, price) {
  const product = shoppingList.find((product) => product.id === id);
  if (product && product.purchased) {
    product.price = price;
  }
}

/**
 * Oblicza łączny koszt zakupionych produktów dla danego dnia.
 * Jeśli produkt nie ma podanej ceny traktujemy go jako darmowy.
 * @param {string} dateStr - Data w formacie string.
 * @returns {number} Łączny koszt zakupów.
 */
function calculateDailyCost(dateStr) {
  const targetDate = new Date(dateStr).toDateString();
  return shoppingList.reduce((total, product) => {
    if (product.purchased && product.date.toDateString() === targetDate) {
      const productCost =
        (typeof product.price === "number" ? product.price : 0) *
        product.quantity;
      return total + productCost;
    }
    return total;
  }, 0);
}

/**
 * Masowo modyfikuje produkty na liście.
 * Przyjmuje listę ID produktów oraz funkcję, która
 * modyfikuje dany produkt.
 * @param {number[]} ids - Lista ID produktów do modyfikacji.
 * @param {function(Product): Product} modifyCallback - Funkcja modyfikująca produkt.
 */
function massUpdateProducts(ids, modifyCallback) {
  shoppingList = shoppingList.map((product) => {
    if (ids.includes(product.id)) {
      return modifyCallback(product);
    }
    return product;
  });
}

/* --------------------- */

// Dodanie produktów
addProduct("Ser", 2, "2025-04-03");
addProduct("Chleb", 1, "2025-04-03");
addProduct("Piwo", 1, "2025-04-04");

// Edycja produktów
const productToEdit = shoppingList[0];
editProductName(productToEdit.id, "Ser Żółty");
editProductQuantity(productToEdit.id, 3);
editProductDate(productToEdit.id, "2025-04-04");

// Zmiana statusu zakupu
editProductStatus(productToEdit.id, true);
setProductPrice(productToEdit.id, 4);

// Zamiana kolejności
if (shoppingList.length >= 2) {
  swapProducts(shoppingList[0].id, shoppingList[1].id);
}

// Wyświetlenie produktów do zakupu dzisiaj
console.log("Produkty do zakupu dzisiaj:", getTodayProducts());

// Obliczenie kosztów zakupionych produktów dla danego dnia
console.log("Koszt zakupów 2025-04-04:", calculateDailyCost("2025-04-04"));

// Przykład masowej modyfikacji
const idsToUpdate = shoppingList.map((product) => product.id);
massUpdateProducts(idsToUpdate, function (product) {
  product.name = "Promocja: " + product.name;
  return product;
});

console.log("Lista produktów po masowej modyfikacji:", shoppingList);
