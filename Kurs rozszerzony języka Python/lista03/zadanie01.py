def is_palindrome(s):
    return s == s[::-1]

def search_for_long_pal(txt):
    txt = txt.lower() 
    txt = ''.join(filter(str.isalnum, txt))  # Usunięcie znaków przestankowych i spacji
    len_txt = len(txt)
    result = []

    for i in range(len_txt):
        for j in range(i + 2, len_txt + 1):
            temp = txt[i:j]
            if is_palindrome(temp):
                result.append((i, j - i))

    if not result: # Jeśli nie ma palindromów zwracamy pustą listę
        return []

    len_limit = max(p[1] for p in result)
    result = [(i, l) for i, l in result if l == len_limit]
    return result

# Przykład użycia
print(search_for_long_pal("To nie palindrom."))  # Wynik: []
print(search_for_long_pal("kajak"))  # Wynik: [(0, 5)]
print(search_for_long_pal("kajak kajakuje"))  # Wynik: [(0, 10)]
print(search_for_long_pal("kajak majam tajat palap"))  # Wynik: [(0, 5), (5, 5), (10, 5), (15, 5)]
print(search_for_long_pal("Ala ma kota, który jest rudy."))  # Wynik: [(0, 3), (2, 3)]
print(search_for_long_pal("A Toyota’s a Toyota’s a Toyota’s a Toyota’s a Toyota’s . . . a Toyota."))  # Wynik: [(0, 47)]
print(search_for_long_pal("Ala kupiła kajak, bo chce przepłynąć Amazonkę z tatą.")) # Wynik: [(9, 5)]