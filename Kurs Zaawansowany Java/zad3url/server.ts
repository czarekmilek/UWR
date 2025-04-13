import express = require("express");
import bodyParser = require("body-parser");
import { Request, Response } from "express";

const app = express();
const port = 8080;

// Middleware do parsowania danych z formularza
app.use(bodyParser.urlencoded({ extended: true }));

function gcd(a: number, b: number): number {
  while (b !== 0) {
    const temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}

// Obsługa żądania POST na ścieżce /gcd
app.post("/gcd", (req: Request, res: Response): void => {
  const a = Number(req.body.a);
  const b = Number(req.body.b);

  if (isNaN(a) || isNaN(b) || a <= 0 || b <= 0 || !Number.isInteger(a) || !Number.isInteger(b)) {
    res
      .status(400)
      .type("text/plain")
      .send("Podano nieprawidłowe dane (liczbę całkowitą ujemną lub element inny niż liczba całkowita).");
    console.log("Podano nieprawidłowe dane: a = "+ a + ", b = " + b);
    return;
  }
  const result = gcd(a, b);
  res.type("text/plain").send(`NWD(${a}, ${b}) = ${result}`);
});

// Uruchomienie serwera
app.listen(port, () => {
  console.log(`Serwer działa na http://localhost:${port}`);
});
