from sqlalchemy import (
    Column, Integer, String, ForeignKey, create_engine
)
from sqlalchemy.orm import relationship, sessionmaker, declarative_base

Base = declarative_base()

class Parent(Base):
    __tablename__ = 'parents'
    id   = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)

    children = relationship('Child', back_populates='parent')

class Child(Base):
    __tablename__ = 'children'
    id        = Column(Integer, primary_key=True)
    name      = Column(String, nullable=False)
    parent_id = Column(Integer, ForeignKey('parents.id'))

    parent = relationship('Parent', back_populates='children')


engine = create_engine('sqlite:///database.db', echo=True)
Session = sessionmaker(bind=engine)

if __name__ == "__main__":
    Base.metadata.create_all(engine)

    session = Session()
    try:
        parent = Parent(name="Ryszard")
        session.add(parent)
        session.flush()
        session.add_all([
            Child(name="Dawid", parent_id=parent.id),
            Child(name="Gibby", parent_id=parent.id),
        ])
        session.commit()
        print("Added parent + children")
    except Exception as e:
        session.rollback()
        print("Something went wrong:", e)
    finally:
        session.close()

    all_parents = Session().query(Parent).all()
    for p in all_parents:
        print(p.name, [c.name for c in p.children])
