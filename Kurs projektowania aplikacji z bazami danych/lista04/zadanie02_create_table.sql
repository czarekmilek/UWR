USE AdventureWorksLT2022

CREATE TABLE [SalesLT].[ProductPriceHistory](
    [ProductID] [INT] NOT NULL,
    [EffectiveDate] [DATETIME] NOT NULL,
    [StandardCost] [MONEY] NOT NULL,
    [ListPrice] [MONEY] NOT NULL,
    CONSTRAINT [PK_ProductPriceHistory] PRIMARY KEY CLUSTERED 
    (
        [ProductID] ASC,
        [EffectiveDate] ASC
    ),
    CONSTRAINT [FK_ProductPriceHistory_Product] FOREIGN KEY([ProductID]) REFERENCES [SalesLT].[Product]([ProductID])
);
