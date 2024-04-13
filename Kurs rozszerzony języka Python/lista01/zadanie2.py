
def is_palindrom(input):
    input = input.lower()
    len_input = len(input)
    forbidden = [',', '.', ' ', ':', ';', '?', '!', '/', '|']
    new_word = []
    
    for i in range(len_input):
        if input[i] not in forbidden:
            new_word.append(input[i])
    
    len_new = len(new_word)
    i = 0

    while i <= len_new//2:
        if new_word[i] != new_word[len_new - 1]:
            return False
        else:
            i += 1
            len_new -= 1
    
    return True

    
#Kilka testów
print(is_palindrom("oko"), "- oko")
print(is_palindrom("rotor"), "- rotor")
print(is_palindrom("Kobyła ma mały bok."), "- Kobyła ma mały bok.")
print(is_palindrom("Eine güldne, gute Tugend: Lüge nie!"), "- Eine güldne, gute Tugend: Lüge nie!")
print(is_palindrom("Míč omočím."), "- Míč omočím.")
print(is_palindrom("kajak"), "- kajak")

print(is_palindrom("To nie jest palindrom"), "- To nie jest palindrom")
print(is_palindrom("To, nie? jest!!! palindrom!!!!"), "- To, nie? jest!!! palindrom!!!!")
print(is_palindrom("Okoń"), "- Okoń")
print(is_palindrom("Konstantynopolitańczykowianeczka"), "- Konstantynopolitańczykowianeczka")
print(is_palindrom("Siała baba mak, nie wiedziała jak."), "- Siała baba mak, nie wiedziała jak.")