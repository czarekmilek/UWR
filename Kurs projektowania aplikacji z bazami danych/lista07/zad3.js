db.createCollection("books", {
    validator: {
       $jsonSchema: {
          bsonType: "object",
          title: "Books Object Validation",
          required: [ "_id", "ISBN", "title", "author", "published_date", "price"],
          properties: {
            ISBN: {
                bsonType: "string",
                description: "'ISBN' must be a string and is required"
             },
             title: {
                bsonType: "string",
                description: "'title' must be a string and is required"
             },
             author: {
                bsonType: "string",
                description: "'author' must be a string and is required"
             },
             published_date: {
                bsonType: "int",
                minimum: 1000,
                maximum: 2023,
                description: "'published_date' must be an int and is required"
             },
             price: {
                bsonType: "int",
                description: "'price' must be an int if the field exists"
             },
             lended_last_month: {
                bsonType: ["int"],
                minimum: 0,
                maximum: 1,
                description: "'lended_last_month' must be a binary value if the field exists"
             },
             specimens: {
                bsonType: ["array"],
                description: "'specimens' must be an array if the field exists",
                items: {
                    bsonType: "object",
                    required: ["_id", "shelf_mark"],
                    properties: {
                        _id: {
                            bsonType: "int",
                            description: "'_id' must be an int and is required"
                        },
                        shelf_mark: {
                            bsonType: "string",
                            description: "'shelf_mark' must be an int and is required"
                        }
                    }
                }
             }
          }
       }
    }
 } )


  db.createCollection("readers", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            title: "Readers Object Validation",
            required: ["_id", "PESEL", "last_name", "city", "birth_date"],
            properties: {
                PESEL: {
                    bsonType: "string",
                    description: "'PESEL' must be a string and is required"
                },
                last_name: {
                    bsonType: "string",
                    description: "'last_name' must be a string and is required"
                },
                city: {
                    bsonType: "string",
                    description: "'city' must be a string and is required"
                },
                birth_date: {
                    bsonType: "string",
                    description: "'birth_date' must be a string and is required"
                },
                borrowings: {
                    bsonType: ["array"],
                    description: "'borrowings' must be an array if the field exists",
                    items: {
                        bsonType: "object",
                        required: ["_id", "speciman_id", "borrow_date", "days"],
                        properties: {
                            _id: {
                                bsonType: "int",
                                description: "'_id' must be an int and is required"
                            },
                            speciman_id: {
                                bsonType: "int",
                                description: "'speciman_id' must be an int and is required"
                            },
                            borrow_date: {
                                bsonType: "string",
                                description: "'borrow_date' must be a string and is required"
                            },
                            days: {
                                bsonType: "int",
                                description: "'days' must be an int and is required"
                            }
                        }
                    }
                }
            }
        }
    }})


db.books.insertOne(
{
    _id: 1, ISBN: '83-246-0279-8',
    title: 'Microsoft Access. Podrêcznik administratora',
    published_date: 2006,
    price: 69,
    lended_last_month: 0,
    specimens: [{_id: 1, shelf_mark: 'S0001'}, {_id: 2, shelf_mark: 'S0002'}, {_id: 3, shelf_mark: 'S0003'}]
})

db.readers.insertOne(
{
    _id: 3,
    PESEL: '55101011111',
    last_name: 'Kowalski',
    city: 30,
    birth_date: '1955-10-10',
    borrowings: [{_id: 1, speciman_id: 4, borrow_date: '2020-02-01', days: 12},
                {_id: 2, speciman_id: 3, borrow_date: '2020-10-11', days: 20}]
})

/*
db.books.insertOne(
    {
        _id: 1, ISBN: '83-246-0279-8',
        title: 'Microsoft Access. Podrêcznik administratora',
        author: 'Adam Nowak'
        published_date: 2006,
        price: 69,
        lended_last_month: 0,
        specimens: [{_id: 1, shelf_mark: 'S0001'}, {_id: 2, shelf_mark: 'S0002'}, {_id: 3, shelf_mark: 'S0003'}]
    })
    
db.readers.insertOne(
{
    _id: 3,
    PESEL: '55101011111',
    last_name: 'Kowalski',
    city: 'Wroclaw',
    birth_date: '1955-10-10',
    borrowings: [{_id: 1, speciman_id: 4, borrow_date: '2020-02-01', days: 12},
                {_id: 2, speciman_id: 3, borrow_date: '2020-10-11', days: 20}]
})
*/