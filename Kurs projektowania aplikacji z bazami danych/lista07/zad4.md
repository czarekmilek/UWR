
- > db.inventory.drop( { writeConcern: { w: 1 } } )

```
db.inventory.insertMany([
    { item: "journal", qty: 25, size: { h: 14, w: 21, uom: "cm" }, status: "F" },
    { item: "notebook", qty: 50, size: { h: 8.5, w: 11, uom: "in" }, status: "E" },
    { item: "paper", qty: 100, size: { h: 8.5, w: 11, uom: "in" }, status: "D" },
    { item: "planner", qty: 75, size: { h: 22.85, w: 30, uom: "cm" }, status: "C" },
    { item: "postcard", qty: 45, size: { h: 10, w: 15.25, uom: "cm" }, status: "B" },
    { item: "postcard2", qty: 45, size: { h: 10, w: 15.25, uom: "cm" }, status: "A" }
 ]);
```
> SELECT * FROM inventory

 Get full documents list:

- > db.inventory.find( {} )

Get full documents list sorted in a specific order:

- > db.inventory.aggregate({$sort : {status : 1}})

Get full documents list sorted in a specific order and limited to the middle 2 items (select a specific page)
pomijamy połowę i wybieramy 2 elementy

```
// db.inventory.find().limit(n)
db.inventory.aggregate([
    {$sort : {status : 1}},
    {$skip: Math.floor(db.inventory.countDocuments() / 2) - 1},
    {$limit: 2}
])
```