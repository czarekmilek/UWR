def kompresja(tekst):
    compressed = []
    i = 0

    while i < len(tekst):
        symbol = tekst[i]
        number = 1

        while i + 1 < len(tekst) and tekst[i + 1] == symbol:
            number += 1
            i += 1

        compressed.append((number, symbol))
        i += 1

    return compressed

def dekompresja(tekst_skompresowany):
    decompressed = ""
    
    for number, symbol in tekst_skompresowany:
        decompressed += symbol * number

    return decompressed

print()
test = "suuuuper"
print(kompresja(test))
print(dekompresja(kompresja(test)))

print(kompresja("scooby-doooooooooo"))
print(dekompresja(kompresja("scooby-doooooooooo")))

print(kompresja("Siała baba mak nie wiedziała jak"))
print(dekompresja(kompresja("Siała baba mak nie wiedziała jak")))

print(kompresja("maaamaaa maaa koootaaaa iiii psssssaaaaa"))
print(dekompresja(kompresja("maaamaaa maaa koootaaaa iiii psssssaaaaa")))


# Fragment książki Adama Mickiewicza - Dziady cz. III, dostępny https://wolnelektury.pl/katalog/lektura/dziady-dziady-poema-dziady-czesc-iii.html
print("\nTekst literacki - Dziady cz. III - Adam Mickiewicz")
fragment = '''Samotność — cóż po ludziach, czy-m śpiewak dla ludzi?
Gdzie człowiek, co z mej pieśni całą myśl wysłucha,
Obejmie okiem wszystkie promienie jej ducha?
Nieszczęsny, kto dla ludzi głos i język trudzi:
Język kłamie głosowi, a głos myślom kłamie;
'''
print(kompresja(fragment))
print()
print(dekompresja(kompresja(fragment)))

