import argparse
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.orm import declarative_base, sessionmaker, relationship
from datetime import date

Base = declarative_base()

class Author(Base):
    __tablename__ = 'authors'
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    books = relationship('Book', back_populates='author', cascade='all, delete-orphan')

class Book(Base):
    __tablename__ = 'books'
    id = Column(Integer, primary_key=True)
    title = Column(String, nullable=False)
    year = Column(Integer)
    author_id = Column(Integer, ForeignKey('authors.id'))
    author = relationship('Author', back_populates='books')
    borrowings = relationship('Borrowing', back_populates='book', cascade='all, delete-orphan')

class Friend(Base):
    __tablename__ = 'friends'
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    email = Column(String, nullable=False, unique=True)
    borrowings = relationship('Borrowing', back_populates='friend', cascade='all, delete-orphan')

class Borrowing(Base):
    __tablename__ = 'borrowings'
    id = Column(Integer, primary_key=True)
    book_id = Column(Integer, ForeignKey('books.id'))
    friend_id = Column(Integer, ForeignKey('friends.id'))
    return_date = Column(String)
    
    book = relationship('Book', back_populates='borrowings')
    friend = relationship('Friend', back_populates='borrowings')

# Inicjalizacja bazy danych
engine = create_engine('sqlite:///book_management.db') 
# załączony plik book_management.db jest przykładowy/testowy 
# swoją bazę można utworzyć od początku używając komend add_{object} zdefiniowanych na końcu programu
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)
session = Session()

# ===================================================
# Podstawowe operacje
# ===================================================

def add_friend(name, email):
    friend = session.query(Friend).filter_by(email=email).first()
    if not friend:
        friend = Friend(name=name, email=email)
        session.add(friend)
        session.commit()
        print(f"Friend '{name}' with email '{email}' successfully added")
    else:
        print("Friend with this email already exists")

def add_book(title, year, author_name):
    author = session.query(Author).filter_by(name=author_name).first()
    if not author:
        author = Author(name=author_name)
        session.add(author)
        session.commit()
        print(f"Author '{author_name}' successfully added")
    
    book = Book(title=title, year=year, author=author)
    session.add(book)
    session.commit()
    print(f"'{title}' by '{author_name}' with release year '{year}' successfully added")

def borrow_book(book_title, friend_name, friend_email):
    book = session.query(Book).filter_by(title=book_title).first()
    friend = session.query(Friend).filter_by(email=friend_email).first()
    
    if book and friend:
        borrowing = Borrowing(book=book, friend=friend)
        session.add(borrowing)
        session.commit()
        print(f"'{book_title}' borrowed by {friend_name}")
    else:
        print("Book or friend not found")

def return_book(book_title, friend_email):
    borrowing = session.query(Borrowing).join(Book).join(Friend).filter(Book.title == book_title, Friend.email == friend_email, Borrowing.return_date == None).first()
    
    if borrowing:
        borrowing.return_date = date.today()
        session.commit()
        print(f"'{book_title}' returned by {friend_email}")
    else:
        print("Borrowing not found")
        
# ===================================================
# Aktualizacja danych
# ===================================================

def update_book_info(book_id, new_title, new_year, new_author_name):
    book = session.query(Book).filter_by(id=book_id).first()
    if book:
        author = session.query(Author).filter_by(name=new_author_name).first()
        if not author:
            author = Author(name=new_author_name)
            session.add(author)
            session.commit()
            print(f"Added new author '{author.name}'")
        book.title = new_title
        book.year = new_year
        book.author = author
        session.commit()
        print(f"Book with ID {book_id} updated.")
    else:
        print(f"Book with ID {book_id} not found.")

def update_author_info(author_id, new_name):
    author = session.query(Author).filter_by(id=author_id).first()
    if author:
        author.name = new_name
        session.commit()
        print(f"Author with ID {author_id} updated.")
    else:
        print(f"Author with ID {author_id} not found.")
        
def update_friend_info(friend_id, new_name, new_email):
    friend = session.query(Friend).filter_by(id=friend_id).first()
    if friend:
        friend.name = new_name
        friend.email = new_email
        session.commit()
        print(f"Friend with ID {friend_id} updated.")
    else:
        print(f"Friend with ID {friend_id} not found.")

def update_borrowing_info(borrowing_id, new_return_date):
    borrowing = session.query(Borrowing).filter_by(id=borrowing_id).first()
    if borrowing:
        borrowing.return_date = new_return_date
        session.commit()
        print(f"Borrowing with ID {borrowing_id} updated.")
    else:
        print(f"Borrowing with ID {borrowing_id} not found.")
        
# ===================================================
# Usuwanie danych
# ===================================================

def delete_author(author_id):
    author = session.query(Author).filter_by(id=author_id).first()
    if author:
        session.delete(author)
        session.commit()
        print(f"Author with ID {author_id} deleted.")
    else:
        print(f"Author with ID {author_id} not found.")

def delete_friend(friend_id):
    friend = session.query(Friend).filter_by(id=friend_id).first()
    if friend:
        session.delete(friend)
        session.commit()
        print(f"Friend with ID {friend_id} deleted.")
    else:
        print(f"Friend with ID {friend_id} not found.")
        
def delete_book(book_id):
    book = session.query(Book).filter_by(id=book_id).first()
    if book:
        session.delete(book)
        session.commit()
        print(f"Book with ID {book_id} deleted.")
    else:
        print(f"Book with ID {book_id} not found.")
        
def delete_borrowing(borrowing_id):
    borrowing = session.query(Borrowing).filter_by(id=borrowing_id).first()
    if borrowing:
        session.delete(borrowing)
        session.commit()
        print(f"Borrowing with ID {borrowing_id} deleted.")
    else:
        print(f"Borrowing with ID {borrowing_id} not found.")
        
# ===================================================
# Lista wszystkiego
# ===================================================

def list_books():
    books = session.query(Book).all()
    
    id_width = 4
    year_width = 10
    author_width = 30
    title_width = 50
    
    print(f"{'ID'.ljust(id_width)} | {'Release'.ljust(year_width)} | {'Author'.ljust(author_width)} | {'Title'.ljust(title_width)}")

    for book in books:
        print(f"{str(book.id).ljust(id_width)} | {str(book.year).ljust(year_width)} | {book.author.name.ljust(author_width)} | {book.title.ljust(title_width)}")

def list_friends():
    friends = session.query(Friend).all()

    id_width = 4
    name_width = 20
    email_width = 50
        
    print(f"{'ID'.ljust(id_width)} | {'Name'.ljust(name_width)} | {'Email'.ljust(email_width)}")

    for friend in friends:
        print(f"{str(friend.id).ljust(id_width)} | {str(friend.name).ljust(name_width)} | {str(friend.email).ljust(email_width)}")

def list_authors():
    authors = session.query(Author).all()

    id_width = 4
    name_width = 20
    
    print(f"{'ID'.ljust(id_width)} | {'Name'.ljust(name_width)}")
    
    for author in authors:
        print(f"{str(author.id).ljust(id_width)} | {str(author.name).ljust(name_width)}")

def list_borrowings():
    borrowings = session.query(Borrowing).all()
    
    id_width = 7
    title_width = 30
    name_width = 20
    date_width = 12
    
    print(f"{'ID'.ljust(id_width)} | {'Book ID'.ljust(id_width)} | {'Book Title'.ljust(title_width)} | {'Name'.ljust(name_width)} | {'Return Date'.ljust(date_width)}")
    
    for borrowing in borrowings:
        print(f"{str(borrowing.id).ljust(id_width)} | {str(borrowing.book_id).ljust(id_width)} | {str(borrowing.book.title).ljust(title_width)} | {str(borrowing.friend.name).ljust(name_width)} | {str(borrowing.return_date).ljust(date_width)}")

# ===================================================
# Przeszukiwanie na podstawie {kryterium}
# ===================================================

def search_book_by_id(id):
    book = session.query(Book).filter_by(id=id).first()
    if book:
        print(f"Book with ID '{id}' found. Info:\nTitle:\t\t{book.title}\nID:\t\t{book.id}\nAuthor:\t\t{book.author.name}\nYear:\t\t{book.year}")
    else:
        print(f"Book '{id}' not found.")
        
def search_book_by_title(title):
    book = session.query(Book).filter_by(title=title).first()
    if book:
        print(f"Book '{title}' found. Info:\nTitle:\t\t{book.title}\nID:\t\t{book.id}\nAuthor:\t\t{book.author.name}\nYear:\t\t{book.year}")
    else:
        print(f"Book '{title}' not found.")
        
def search_book_by_year(year):
    book = session.query(Book).filter_by(year=year).all()
    if book:
        print(f"Book/s with release year '{year}' found. Info:")
        for spec in book:
            print(f"| ID: {spec.id}  | Author ID: {spec.author_id} | Title: {spec.title}")
    else:
        print(f"No book with release year '{year}' not found.")

def search_author_by_id(id):
    author = session.query(Author).filter_by(id=id).first()
    if author:
        print(f"Author with ID '{id}' found. Info:\nID:\t\t{author.id}\nName:\t\t{author.name}\nBooks:")
        for book in author.books:
            print(f"| ID: {book.id}  | Year: {book.year} | Title: {book.title}")
    else:
        print(f"Author with ID '{id}' not found.")
        
def search_author_by_name(name):
    author = session.query(Author).filter_by(name=name).first()
    if author:
        print(f"Author '{name}' found. Info:\nID:\t\t{author.id}\nName:\t\t{author.name}\nBooks:")
        for book in author.books:
            print(f"| ID: {book.id}  | Year: {book.year} | Title: {book.title}")
    else:
        print(f"Author '{name}' not found.")

def search_friend_by_id(id):
    friend = session.query(Friend).filter_by(id=id).first()
    if friend:
        print(f"Friend with ID '{id}' found. Info:\nID:\t\t{friend.id}\nName:\t\t{friend.name}\nEmail:\t\t{friend.email}\nBorrowings:")
        for borrow in friend.borrowings:
            print(f"| Book ID: {borrow.book_id}\t| Return date: {borrow.return_date}")
    else:
        print(f"Friend with ID '{id}' not found.")

def search_friend_by_name(name):
    friend = session.query(Friend).filter_by(name=name).first()
    if friend:
        print(f"Friend '{name}' found. Info:\nID:\t\t{friend.id}\nName:\t\t{name}\nEmail:\t\t{friend.email}\nBorrowings:")
        for borrow in friend.borrowings:
            print(f"| Book ID: {borrow.book_id}\t| Return date: {borrow.return_date}")
    else:
        print(f"Friend '{name}' not found.")

def search_friend_by_email(email):
    friend = session.query(Friend).filter_by(email=email).first()
    if friend:
        print(f"Friend with email '{email}' found. Info:\nID:\t\t{friend.id}\nName:\t\t{friend.name}\nEmail:\t\t{friend.email}\nBorrowings:")
        for borrow in friend.borrowings:
            print(f"| Book ID: {borrow.book_id}\t| Return date: {borrow.return_date}")
    else:
        print(f"Friend with email '{email}' not found.")
        
# ===================================================
# ===================================================

def main():
    parser = argparse.ArgumentParser(description="Book Management System")
    subparsers = parser.add_subparsers(title="Commands", dest="command")

    add_friend_parser = subparsers.add_parser("add_friend", help="Add a new friend")
    add_friend_parser.add_argument("--name", required=True, help="Friend's name")
    add_friend_parser.add_argument("--email", required=True, help="Friend's email")

    add_book_parser = subparsers.add_parser("add_book", help="Add a new book")
    add_book_parser.add_argument("--title", required=True, help="Book title")
    add_book_parser.add_argument("--year", required=True, type=int, help="Publication year")
    add_book_parser.add_argument("--author", required=True, help="Author's name")

    borrow_book_parser = subparsers.add_parser("borrow_book", help="Borrow a book")
    borrow_book_parser.add_argument("--title", required=True, help="Book title")
    borrow_book_parser.add_argument("--fname", required=True, help="Friend's name")
    borrow_book_parser.add_argument("--femail", required=True, help="Friend's email")

    return_book_parser = subparsers.add_parser("return_book", help="Return a borrowed book")
    return_book_parser.add_argument("--title",  required=True, help="Book title")
    return_book_parser.add_argument("--fname",  required=True, help="Friend's name")
    return_book_parser.add_argument("--femail", required=True, help="Friend's email")

    update_book_info_parser = subparsers.add_parser("update_book_info", help="Update info of a book")
    update_book_info_parser.add_argument("--id", required=True, type=int, help="Book ID")
    update_book_info_parser.add_argument("--ntitle", required=True, help="New title")
    update_book_info_parser.add_argument("--nyear", required=True, type=int, help="New publication year")
    update_book_info_parser.add_argument("--nauthor", required=True, help="New author's name")

    update_author_info_parser = subparsers.add_parser("update_author_info", help="Update info of an author")
    update_author_info_parser.add_argument("--id", required=True, type=int, help="Author ID")
    update_author_info_parser.add_argument("--nname", required=True, help="New author's name")
    
    update_friend_info_parser = subparsers.add_parser("update_friend_info", help="Update info of a friend")
    update_friend_info_parser.add_argument("--id", required=True, type=int, help="Friend ID")
    update_friend_info_parser.add_argument("--nname", required=True, help="New friend's name")
    update_friend_info_parser.add_argument("--nemail", required=True, help="New friend's email")
    
    update_borrowing_info_parser = subparsers.add_parser("update_borrowing_info", help="Update info of a borrowing")
    update_borrowing_info_parser.add_argument("--id", required=True, type=int, help="Borrowing ID")
    update_borrowing_info_parser.add_argument("--nreturn_date", required=True, help="New return date")
        
    delete_author_parser = subparsers.add_parser("delete_author", help="Delete an author. DISCLAIMER: Deleting an author deletes his/her books")
    delete_author_parser.add_argument("--id", required=True, type=int, help="Author ID")

    delete_friend_parser = subparsers.add_parser("delete_friend", help="Delete a friend. DISCLAIMER: Deleting a friend deletes his/her borrowings")
    delete_friend_parser.add_argument("--id", required=True, type=int, help="Friend ID")

    delete_book_parser = subparsers.add_parser("delete_book", help="Delete a book")
    delete_book_parser.add_argument("--id", required=True, type=int, help="Book ID")

    delete_borrowing_parser = subparsers.add_parser("delete_borrowing", help="Delete a borrowing")
    delete_borrowing_parser.add_argument("--id", required=True, type=int, help="Borrowing ID")
    
    list_books_parser = subparsers.add_parser("list_books", help="List all books")
    list_friends_parser = subparsers.add_parser("list_friends", help="List all friends")
    list_authors_parser = subparsers.add_parser("list_authors", help="List all authors")
    list_borrowings_parser = subparsers.add_parser("list_borrowings", help="List all borrowings")
    
    search_book_by_id_parser = subparsers.add_parser("search_book_by_id", help="Search whether a book with the given ID exists in database")
    search_book_by_id_parser.add_argument("--id", required=True, help="Book's ID")
    search_book_by_title_parser = subparsers.add_parser("search_book_by_title", help="Search whether a book with the given title exists in database")
    search_book_by_title_parser.add_argument("--title", required=True, help="Book's title")
    search_book_by_year_parser = subparsers.add_parser("search_book_by_year", help="Search whether a book with the given release year exists in database")
    search_book_by_year_parser.add_argument("--year", required=True, help="Book's release year")
    
    search_author_by_id_parser = subparsers.add_parser("search_author_by_id", help="Search whether author with given id exists in database")
    search_author_by_id_parser.add_argument("--id", required=True, help="Author's id")
    search_author_by_name_parser = subparsers.add_parser("search_author_by_name", help="Search whether author with given name exists in database")
    search_author_by_name_parser.add_argument("--name", required=True, help="Author's name")
    
    search_friend_by_id_parser = subparsers.add_parser("search_friend_by_id", help="Search whether friend with given id exists in database")
    search_friend_by_id_parser.add_argument("--id", required=True, help="Friend's id")
    search_friend_by_name_parser = subparsers.add_parser("search_friend_by_name", help="Search whether friend with given name exists in database")
    search_friend_by_name_parser.add_argument("--name", required=True, help="Friend's name")
    search_friend_by_email_parser = subparsers.add_parser("search_friend_by_email", help="Search whether friend with given email exists in database")
    search_friend_by_email_parser.add_argument("--email", required=True, help="Friend's email")
    
    args = parser.parse_args()

    if args.command == "add_friend":
        add_friend(args.name, args.email)
    elif args.command == "add_book":
        add_book(args.title, args.year, args.author)
    elif args.command == "borrow_book":
        borrow_book(args.title, args.fname, args.femail)
    elif args.command == "return_book":
        return_book(args.title, args.femail)
        
    elif args.command == "update_book_info":
        update_book_info(args.id, args.ntitle, args.nyear, args.nauthor)
    elif args.command == "update_author_info":
        update_author_info(args.id, args.nname)
    elif args.command == "update_friend_info":
        update_friend_info(args.id, args.nname, args.nnemail)
    elif args.command == "update_borrowing_info":
        update_borrowing_info(args.id, args.nreturn_date)
        
    elif args.command == "delete_author":
        delete_author(args.id)
    elif args.command == "delete_friend":
        delete_friend(args.id)
    elif args.command == "delete_book":
        delete_book(args.id)
    elif args.command == "delete_borrowing":
        delete_borrowing(args.id)
        
    elif args.command == "list_books":
        list_books()
    elif args.command == "list_friends":
        list_friends()
    elif args.command == "list_authors":
        list_authors()
    elif args.command == "list_borrowings":
        list_borrowings()
        
    elif args.command == "search_book_by_id":
        search_book_by_id(args.id)
    elif args.command == "search_book_by_title":
        search_book_by_title(args.title)
    elif args.command == "search_book_by_year":
        search_book_by_year(args.year)
        
    elif args.command == "search_author_by_id":
        search_author_by_id(args.id)
    elif args.command == "search_author_by_name":
        search_author_by_name(args.name)
    
    elif args.command == "search_friend_by_id":
        search_friend_by_id(args.id)
    elif args.command == "search_friend_by_name":
        search_friend_by_name(args.name)
    elif args.command == "search_friend_by_email":
        search_friend_by_email(args.email)

    else:
        print("Invalid command. Use --help for usage information.")

if __name__ == "__main__":
    main()
