# Lista 1 | POO

## Zadanie 1
![image](https://hackmd.io/_uploads/rywFM4AiJg.png)


### **F** – Functionality

1. **Moduł Wnioskodawcy**
    - **Opis:**
    System musi umożliwiać elektroniczne składanie wniosków, ich edycję oraz podgląd statusu i wyników ich oceny (np. wyświetlenie komunikatów o przyjęciu wniosku, potwierdzenia oraz historii modyfikacji).
    - **Ocena S.M.A.R.T.:**
    Szczegółowe, mierzalne i osiągalne.
   - **Hipotetyczne pytanie do Zamawiającego:**
    „*Jakie formaty danych i jakie szczegółowe informacje powinny być dostępne w module Wnioskodawcy?*”
2. **Moduł Urząd**
    - **Opis:**
    System musi umożliwiać elektroniczne zarządzanie przychodzącymi wnioskami obejmujące rejestrację, przekazywanie do korekty (w przypadku błędów) oraz komunikację z modułem Wnioskodawcy.
   - **Ocena S.M.A.R.T.:**
    Szczegółowe, mierzalne i osiągalne.
   - **Hipotetyczne pytanie do Zamawiającego:**
   „*Jakie dokładne operacje powinny być wspierane przez moduł Urząd?*”

---

### **U** – Usability

3. **Dostępność przez Internet**
    - **Opis:**
    Oferowany system musi umożliwiać dostęp do interfejsu za pomocą dowolnego komputera przez przeglądarkę internetową.
    - **Ocena S.M.A.R.T.:**
    Proste, mierzalne, osiągalne, realistyczne i terminowe.
   - **Hipotetyczne pytanie do Zamawiającego:**
   „*Jakie przeglądarki i ich wersje (oraz ewentualnie systemy operacyjne) są wymagane do prawidłowego korzystania z systemu?*”
4. **Intuicyjny interfejs użytkownika**
   - **Opis:**
    System powinien posiadać przejrzysty i intuicyjny interfejs, który ułatwi użytkownikom szybkie odnalezienie potrzebnych funkcji.
   - **Ocena S.M.A.R.T.:**
    Proste, mierzalne, osiągalne i realistyczne.
   - **Hipotetyczne pytanie do Zamawiającego:**
   „*Jakie kryteria oceny intuicyjności interfejsu (np. czas na wykonanie zadania, wskaźnik błędów) będą stosowane przy ocenie systemu?*”

---

### **R** – Reliability

5. **Integralność danych**
   - **Opis:**
    System musi zapewnić integralność danych przesyłanych między modułami przy użyciu odpowiednich mechanizmów weryfikacyjnych.
   - **Ocena S.M.A.R.T.:**
    Specyficzne, mierzalne oraz realistyczne do wdrożenia.
   - **Hipotetyczne pytanie do Zamawiającego:**
   „*Jakie mechanizmy powinny być zastosowane do weryfikacji integralności danych przesyłanych między modułami?*”
6. **Wysoka dostępność**
   - **Opis:**
    System powinien być dostępny przez określony procent czasu w godzinach pracy.
   - **Ocena S.M.A.R.T.:**
    Mierzalne, konkretne i osiągalne.
   - **Hipotetyczne pytanie do Zamawiającego:**
   „*Czy istnieją szczegółowe wymagania dotyczące procentowego poziomu dostępności systemu oraz sposobu monitorowania tego parametru?*”

---

### **P** – Performance

7. **Czas reakcji systemu**
   - **Opis:**
    System musi przetwarzać operacje w czasie nie przekraczającym określonej granicy przy standardowym obciążeniu.
   - **Ocena S.M.A.R.T.:**
    Mierzalne, określone, konkretne i realistyczne.
   - **Hipotetyczne pytanie do Zamawiającego:**
   „*Jaki jest maksymalny dopuszczalny czas odpowiedzi systemu przy określonym obciążeniu?*”

---

### **S** – Supportability

8. **Usługa hostingowa i wsparcie techniczne**
   - **Opis:**
    System musi być dostarczony wraz z 12-miesięczną usługą hostingu oraz wsparciem technicznym.
   - **Ocena S.M.A.R.T.:**
    Mierzalne (okres 12 miesięcy, określone wskaźniki wsparcia) oraz realistyczne.
   - **Hipotetyczne pytanie do Zamawiającego:**
   „*Jakie są oczekiwania odnośnie do czasu reakcji na zgłoszenia serwisowe oraz jakie wskaźniki mają być spełnione w ramach usługi hostingowej?*”


---

## Zadanie 2
![image](https://hackmd.io/_uploads/SJB9fV0jJl.png)

### Brief
#### Przypadek użycia: Zakupy w sklepie internetowym

Klient, będący zalogowanym użytkownikiem, przegląda zawartość koszyka, zatwierdza zamówienie, wybiera metodę płatności, podaje dane płatności, a system autoryzuje transakcję, aktualizuje stan magazynowy i generuje potwierdzenie zamówienia. W przypadku błędów przy płatności lub aktualizacji magazynu system wyświetla komunikaty umożliwiające poprawienie sytuacji.

### Fully Dressed
#### Przypadek użycia: Zakupy w sklepie internetowym

**Cel:**
Pozwolić klientowi na złożenie zamówienia za pośrednictwem systemu sklepu internetowego.

**Interesariusze:**
- **Klient:** Osoba, która przegląda produkty i składa zamówienie.
- **System sklepu online:** Odpowiedzialny za przetwarzanie zamówienia, obsługę płatności i aktualizację stanu magazynowego.

**Warunki początkowe:**
- Klient jest zalogowany do systemu.
- Produkty w sklepie są dostępne do zakupu.
- Za produkty można zapłacić używając systemu płatności.
- Klient posiada w koszyku przynajmniej jeden produkt.

**Warunki końcowe:**
- Zamówienie zostaje zarejestrowane, a płatność przetworzona pomyślnie.
- Klient otrzymuje potwierdzenie zamówienia.

**Główny scenariusz sukcesu:**
1. Klient przegląda zawartość koszyka i decyduje się na finalizację zakupu.
2. System wyświetla szczegóły koszyka oraz całkowitą kwotę do zapłaty.
3. Klient zatwierdza zamówienie i przechodzi do formularza wyboru metody płatności.
4. Klient podaje dane płatności.
5. System autoryzuje płatność oraz aktualizuje stan magazynowy.
6. System generuje potwierdzenie zamówienia i wysyła je do klienta.

**Rozszerzenia:**
- **Niewystarczające środki lub błąd autoryzacji płatności:**
  - System wyświetla komunikat o błędzie, umożliwiając klientowi wybranie innej metody płatności.
- **Błąd systemowy przy aktualizacji stanu magazynowego:**
  - System anuluje zamówienie i informuje klienta o problemie, sugerując kontakt z działem obsługi klienta.

**Dodatkowe wymagania:**
- Wszystkie operacje muszą być przetwarzane w czasie nie przekraczającym 5 sekund (przy standardowym obciążeniu).
- Interfejs musi być dostępny zarówno na komputerach stacjonarnych, jak i urządzeniach mobilnych.

---

## Zadanie 3
![image](https://hackmd.io/_uploads/ByDDHE0oJx.png)

1. **Client**
   - **Opis:** Osoba korzystająca ze sklepu internetowego.
   - **Atrybuty:** Dane osobowe (imię, nazwisko, adres e-mail) oraz historia zamówień.
   - **Powiązania:** Posiada koszyk (`ShoppingCart`), składa zamówienia (`Order`), ma przypisane adresy (`Address`) oraz listę życzeń (`Wishlist`).
2. **Product**
   - **Opis:** Przedmiot dostępny do zakupu w sklepie.
   - **Atrybuty:** Identyfikator, nazwa, opis, cena, stan magazynowy.
   - **Powiązania:** Może być dodany do koszyka (`ShoppingCart`), wchodzić w skład zamówienia (`Order`), należy do jednej lub więcej kategorii (`Category`) oraz może posiadać opinie (`Review`).
3. **ShoppingCart**
   - **Opis:** Tymczasowy zbiór produktów wybranych przez klienta przed finalizacją zakupu.
   - **Atrybuty:** Informacje o liczbie sztuk każdego produktu, łączna wartość.
   - **Powiązania:** Należy do `Klienta` i zawiera jeden lub więcej `Produktów`.
4. **Order**
   - **Opis:** Zarejestrowana transakcja zakupu.
   - **Atrybuty:** Lista zakupionych produktów, data zamówienia, status realizacji, łączna kwota.
   - **Powiązania:** Zostaje utworzone przez `Klienta`, zawiera `Produkty`, jest powiązane z płatnością (`Payment`), może mieć przypisaną promocję (`Sale`), adres wysyłki (`Address`) oraz dane dotyczące dostawy (`Shipment`).
5. **Payment**
   - **Opis:** Reprezentuje proces przetwarzania transakcji finansowej.
   - **Atrybuty:** Metoda płatności, kwota, status transakcji.
   - **Powiązania:** Jest przypisana do Zamówienia (`Order`).
6. **Category**
   - **Opis:** Klasyfikacja produktów w sklepie internetowym.
   - **Atrybuty:** Identyfikator kategorii, nazwa, opis.
   - **Powiązania:** Każdy `Produkt` należy do jednej lub więcej kategorii.
7. **Review**
   - **Opis:** Informacja zwrotna lub ocena produktu przez klienta.
   - **Atrybuty:** Ocena, komentarz, data wystawienia.
   - **Powiązania:** Każda opinia jest przypisana do konkretnego `Produktu` oraz może być powiązana z `Klientem`, który ją wystawił.
8. **Address**
   - **Opis:** Dane adresowe używane do celów wysyłki lub fakturowania.
   - **Atrybuty:** Ulica, numer, miasto, kod pocztowy, kraj.
   - **Powiązania:** `Klient` posiada jeden adres; `Zamówienie` korzysta z adresu wysyłki oraz adresu do fakturowania.
9. **Shipment**
   - **Opis:** Informacje dotyczące wysyłki zamówienia.
   - **Atrybuty:** Metoda wysyłki, numer śledzenia, przewidywana data dostarczenia.
   - **Powiązania:** Każde `Zamówienie` może mieć przypisane dane dotyczące dostawy.
10. **Sale**
    - **Opis:** Oferta rabatowa lub specjalna promocja związana z produktem lub zamówieniem.
    - **Atrybuty:** Kod promocyjny, wartość rabatu, okres ważności promocji.
    - **Powiązania:** Może być przypisana do `Produktu`.
11. **Wishlist**
    - **Opis:** Lista produktów, które Klient chciałby zakupić w przyszłości.
    - **Atrybuty:** Zbiór produktów zapisanych przez Klienta.
    - **Powiązania:** Każdy `Klient` może posiadać jedną listę życzeń zawierającą `Produkty`.

---

## Zadanie 4
![image](https://hackmd.io/_uploads/HyvbFVAiyg.png)

---

### Diagram Modelu Pojęciowego
![image](https://hackmd.io/_uploads/ry2PuCCoyl.png)

---

### Diagram Klas UML
![image](https://hackmd.io/_uploads/Hyezdyk2yx.png)

---
