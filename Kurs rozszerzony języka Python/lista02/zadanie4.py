import random

def uprosc_zdanie(text, max_dl_slowa, max_liczba_slow):
    words = text.split()
    short_words = [slowo for slowo in words if len(slowo) <= max_dl_slowa]
    
    if len(short_words) > max_liczba_slow:
        to_delete = len(short_words) - max_liczba_slow
        indexes_to_delete = random.sample(range(len(short_words)), to_delete)
        
        for indeks in sorted(indexes_to_delete, reverse=True):
            slowo = short_words.pop(indeks)
            text = text.replace(slowo, '', 1)
    
    return ' '.join(short_words)

test = '''Podział peryklinalny inicjałów wrzecionowatych kambium charakteryzuje się ścianą
podziałową inicjowaną w płaszczyźnie maksymalnej'''
print("\nMax length:", 10, "| Max words:", 5)
print(uprosc_zdanie(test, 10, 5))
print("-------------------------------------------")

# Fragment książki Adama Mickiewicza - Dziady cz. III, dostępny https://wolnelektury.pl/katalog/lektura/dziady-dziady-poema-dziady-czesc-iii.html
print("\nTekst literacki - Dziady cz. III - Adam Mickiewicz")
print("-------------------------------------------")
fragment = '''Samotność — cóż po ludziach, czy-m śpiewak dla ludzi?
Gdzie człowiek, co z mej pieśni całą myśl wysłucha,
Obejmie okiem wszystkie promienie jej ducha?
Nieszczęsny, kto dla ludzi głos i język trudzi:
Język kłamie głosowi, a głos myślom kłamie;
Myśl z duszy leci bystro, nim się w słowach złamie,
A słowa myśl pochłoną i tak drżą nad myślą,
Jak ziemia nad połkniętą, niewidzialną rzeką.
Z drżenia ziemi czyż ludzie głąb nurtów docieką.
Gdzie pędzi, czy się domyślą? —
Uczucie krąży w duszy, rozpala się, żarzy,
Jak krew po swych głębokich, niewidomych cieśniach;
Ile krwi tylko ludzie widzą w mojej twarzy,
Tyle tylko z mych uczuć dostrzegą w mych pieśniach. 
Pieśni ma, tyś jest gwiazdą za granicą świata!
I wzrok ziemski, do ciebie wysłany za gońca,
Choć szklanne weźmie skrzydła, ciebie nie dolata,
Tylko o twoję mleczną drogę się uderzy;
Domyśla się, że to słońca,
Lecz ich nie zliczy, nie zmierzy.
Wam, pieśni, ludzkie oczy, uszy, niepotrzebne; —
Płyńcie w duszy mej wnętrznościach,
Świećcie na jej wysokościach,
Jak strumienie podziemne, jak gwiazdy nadniebne.
Ty Boże, ty naturo! dajcie posłuchanie. —
Godna to was muzyka i godne śpiewanie. — 
Ja mistrz!
Ja mistrz wyciągam dłonie!
Wyciągam aż w niebiosa i kładę me dłonie
Na gwiazdach jak na szklannych harmoniki kręgach.
To nagłym, to wolnym ruchem,
Kręcę gwiazdy moim duchem.
Milijon tonów płynie; w tonów milijonie
Każdy ton ja dobyłem, wiem o każdym tonie;
Zgadzam je, dzielę i łączę,
I w tęcze, i w akordy, i we strofy plączę,
Rozlewam je we dźwiękach i w błyskawic wstęgach. —
Odjąłem ręce, wzniosłem nad świata krawędzie,
I kręgi harmoniki wstrzymały się w pędzie.
Sam śpiewam, słyszę me śpiewy —
Długie, przeciągłe jak wichru powiewy,
Przewiewają ludzkiego rodu całe tonie,
Jęczą żalem, ryczą burzą,
I wieki im głucho wtórzą;
A każdy dźwięk ten razem gra i płonie,
Mam go w uchu, mam go w oku,
Jak wiatr, gdy fale kołysze,
Po świstach lot jego słyszę,
Widzę go w szacie obłoku.
Boga, natury godne takie pienie!
Pieśń to wielka, pieśń-tworzenie.
Taka pieśń jest siła, dzielność,
Taka pieśń jest nieśmiertelność!
Ja czuję nieśmiertelność, nieśmiertelność tworzę,
Cóż Ty większego mogłeś zrobić — Boże? 
Patrz, jak te myśli dobywam sam z siebie,
Wcielam w słowa, one lecą,
Rozsypują się po niebie,
Toczą się, grają i świecą;
Już dalekie, czuję jeszcze,
Ich wdziękami się lubuję,
Ich okrągłość dłonią czuję,
Ich ruch myślą odgaduję:
Kocham was, me dzieci wieszcze!
Myśli moje! gwiazdy moje!
Czucia moje! wichry moje!
W pośrodku was jak ojciec wśród rodziny stoję,
Wy wszystkie moje! 
Depcę was, wszyscy poeci,
Wszyscy mędrce i proroki,
Których wielbił świat szeroki.
Gdyby chodzili dotąd śród swych dusznych dzieci,
Gdyby wszystkie pochwały i wszystkie oklaski
Słyszeli, czuli i za słuszne znali,
I wszystkie sławy każdodziennej blaski
Promieniami na wieńcach swoich zapalali;
Z całą pochwał muzyką i wieńców ozdobą,
Zebraną z wieków tyla i z pokoleń tyla,
Nie czuliby własnego szczęścia, własnej mocy
Jak ja dziś czuję w tej samotnej nocy:
Kiedy sam śpiewam w sobie,
Śpiewam samemu sobie. 
Tak! — czuły jestem, silny jestem i rozumny. —
Nigdym nie czuł, jak w tej chwili —
Dziś mój zenit, moc moja dzisiaj się przesili,
Dziś poznam, czym najwyższy, czylim tylko dumny;
Dziś jest chwila przeznaczona,
Dziś najsilniej wytężę duszy mej ramiona —
To jest chwila Samsona,
Kiedy więzień i ślepy dumał u kolumny.
Zrzucę ciało i tylko jak duch wezmę pióra —
Potrzeba mi lotu,
Wylecę z planet i gwiazd kołowrotu,
Tam dojdę, gdzie graniczą Stwórca i natura.
I mam je, mam je, mam — tych skrzydeł dwoje;
Wystarczą: — od zachodu na wschód je rozszerzę,
Lewym o przeszłość, prawym o przyszłość uderzę.
I dojdę po promieniach uczucia — do Ciebie'''
print("Max length:", 5, "| Max words:", 30)
print(uprosc_zdanie(fragment, 30, 5))
print("-------------------------------------------")
print("Max length:", 10, "| Max words:", 30)
print(uprosc_zdanie(fragment, 30, 10))
print("-------------------------------------------")
print("Max length:", 15, "| Max words:", 20)
print(uprosc_zdanie(fragment, 20, 15))
print("-------------------------------------------")
print("Max length:", 27, "| Max words:", 10)
print(uprosc_zdanie(fragment, 10, 27))
print("-------------------------------------------")
print("Max length:", 20, "| Max words:", 50)
print(uprosc_zdanie(fragment, 50, 20))
print("-------------------------------------------")
print("Max length:", 10, "| Max words:", 10)
print(uprosc_zdanie(fragment, 10, 10))
print("-------------------------------------------")