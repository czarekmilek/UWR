import html.parser
import urllib.request
import re

# Dziedziczy po HTMLParser i przeszukuje strony w poszukiwaniu linków
class Crawler(html.parser.HTMLParser):
    def __init__(self):
        html.parser.HTMLParser.__init__(self)
        self.links = set()

    def handle_starttag(self, tag, attrs):
        if tag == 'a':
            for (att, val) in attrs:
                if att == 'href': 
                    if re.match(r'https?://([a-zA-Z]+\.)*[a-zA-Z]+', val):
                        self.links.add(val) # Zbiór przechowujący unikalne linki

def crawl(start_page, distance, action):
    crawler = Crawler()
    
    checked = set()
    unchecked = [(start_page, 0)]
    
    while len(unchecked) > 0:
        if unchecked[0][1] > distance:
            break  # Zakończ przeszukiwanie, jeśli osiągnięto maksymalną głębokość

        
        try:
            req = urllib.request.urlopen(unchecked[0][0])  # Otwarcie połączenia z daną stroną
        except EnvironmentError as error:
            print(unchecked[0][0], error)  # Wyświetlenie błędu, jeśli wystąpił
            
        
        else:
            page = req.read().decode('utf-8')  # Odczytanie zawartości strony
            crawler.feed(page)  # Przetworzenie strony przez parser HTML
            yield (unchecked[0][0], action(page))  # Zwrócenie adresu strony i wyniku action
        
        finally:
            checked.add(unchecked[0][0])  # Odhaczenie sprawdzonej strony
            
            unchecked.extend((url, unchecked[0][1] + 1) for url in crawler.links - checked)
            unchecked = unchecked[1:]  # Usunięcie pierwszego elementu z niesprawdzonych

#--------------------------------

# Dziedziczy po HTMLParser i służy do wyszukiwania zdań zawierających określone słowo kluczowe
class Searcher(html.parser.HTMLParser):
    def __init__(self, word):
        html.parser.HTMLParser.__init__(self)
        # Szukanie zdań zawierających dane słowo kluczowe
        self.regEx = re.compile(r'(\b' + word + r'\b|[A-Z][^\.]*?\b' + word + r'\b).*?[\.!?](?:\s|$)')
        self.sent_with_word = []  # Lista zdań zawierających słowo kluczowe

    # Metoda wywoływana przy napotkaniu danych wewnątrz
    def handle_data(self, data):
        # Dodanie zdań zawierających słowo kluczowe do listy
        self.sent_with_word.extend([sent.group() for sent in self.regEx.finditer(data)])

def search(word):
    # foo to funkcja przekształcająca stronę HTML
    def foo(htmlPage):
        parser = Searcher(word)
        parser.feed(htmlPage)
        return parser.sent_with_word
    return foo

#--------------------------------

# wypisanie wyniku
def execute(result, limit):
    for url, wynik in enumerate(result, start = 1):
        if url <= limit:
            print(f"{url}: {wynik}\n")
        else:
            break

#--------------------------------

execute(crawl('https://www.learnpython.org/', 1, search('Python')), 13)
print("------------------------------------------------------------------")
execute(crawl('https://docs.python.org/3/', 1, search('Python')), 17)
print("------------------------------------------------------------------")
execute(crawl('https://www.python.org/about/', 1, search('Python')), 21)