
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 08/06/2012 15:34:21
-- Generated from EDMX file: D:\Source\src\LogicLibary\StoreDb.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [StoreDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_OrderHeadOrderBodySet]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderBodySet] DROP CONSTRAINT [FK_OrderHeadOrderBodySet];
GO
IF OBJECT_ID(N'[dbo].[FK_GoodsUnitGoods]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EntitySet_Goods] DROP CONSTRAINT [FK_GoodsUnitGoods];
GO
IF OBJECT_ID(N'[dbo].[FK_BrandGoods]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EntitySet_Goods] DROP CONSTRAINT [FK_BrandGoods];
GO
IF OBJECT_ID(N'[dbo].[FK_GoodsChanged]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EntitySet_Changed] DROP CONSTRAINT [FK_GoodsChanged];
GO
IF OBJECT_ID(N'[dbo].[FK_BrandBrand]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EntitySet_Brand] DROP CONSTRAINT [FK_BrandBrand];
GO
IF OBJECT_ID(N'[dbo].[FK_GoodsUnit_inherits_Entity]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EntitySet_GoodsUnit] DROP CONSTRAINT [FK_GoodsUnit_inherits_Entity];
GO
IF OBJECT_ID(N'[dbo].[FK_Goods_inherits_Entity]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EntitySet_Goods] DROP CONSTRAINT [FK_Goods_inherits_Entity];
GO
IF OBJECT_ID(N'[dbo].[FK_Brand_inherits_Entity]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EntitySet_Brand] DROP CONSTRAINT [FK_Brand_inherits_Entity];
GO
IF OBJECT_ID(N'[dbo].[FK_Changed_inherits_Entity]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EntitySet_Changed] DROP CONSTRAINT [FK_Changed_inherits_Entity];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[OrderBodySet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderBodySet];
GO
IF OBJECT_ID(N'[dbo].[OrderHeadSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderHeadSet];
GO
IF OBJECT_ID(N'[dbo].[EntitySet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EntitySet];
GO
IF OBJECT_ID(N'[dbo].[EntitySet_GoodsUnit]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EntitySet_GoodsUnit];
GO
IF OBJECT_ID(N'[dbo].[EntitySet_Goods]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EntitySet_Goods];
GO
IF OBJECT_ID(N'[dbo].[EntitySet_Brand]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EntitySet_Brand];
GO
IF OBJECT_ID(N'[dbo].[EntitySet_Changed]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EntitySet_Changed];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'OrderBodySet'
CREATE TABLE [dbo].[OrderBodySet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Value] smallint  NOT NULL,
    [OrderHead_ID] int  NOT NULL
);
GO

-- Creating table 'OrderHeadSet'
CREATE TABLE [dbo].[OrderHeadSet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Buyer] nvarchar(max)  NOT NULL,
    [Sum] int  NOT NULL,
    [Status] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'EntitySet'
CREATE TABLE [dbo].[EntitySet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [UserKey] nvarchar(max)  NOT NULL,
    [Modified] datetime  NOT NULL
);
GO

-- Creating table 'EntitySet_GoodsUnit'
CREATE TABLE [dbo].[EntitySet_GoodsUnit] (
    [UnitName] nvarchar(max)  NOT NULL,
    [Enable] bit  NOT NULL,
    [ID] int  NOT NULL
);
GO

-- Creating table 'EntitySet_Goods'
CREATE TABLE [dbo].[EntitySet_Goods] (
    [GoodsName] nvarchar(50)  NOT NULL,
    [Quantity] decimal(18,0)  NOT NULL,
    [Enable] bit  NOT NULL,
    [ID] int  NOT NULL,
    [Unit_ID] int  NOT NULL,
    [Brand_ID] int  NOT NULL
);
GO

-- Creating table 'EntitySet_Brand'
CREATE TABLE [dbo].[EntitySet_Brand] (
    [BrandName] nvarchar(max)  NOT NULL,
    [ID] int  NOT NULL,
    [RootBrand_ID] int  NULL
);
GO

-- Creating table 'EntitySet_Changed'
CREATE TABLE [dbo].[EntitySet_Changed] (
    [Value] decimal(18,0)  NOT NULL,
    [Date] datetime  NOT NULL,
    [Quantity] decimal(18,0)  NOT NULL,
    [PieceCost] decimal(18,0)  NOT NULL,
    [ID] int  NOT NULL,
    [Goods_ID] int  NOT NULL
);
GO

-- Creating table 'EntitySet_Price'
CREATE TABLE [dbo].[EntitySet_Price] (
    [Value] decimal(18,0)  NOT NULL,
    [BeforeTax] bit  NOT NULL,
    [DiscountLimits] decimal(18,0)  NOT NULL,
    [ID] int  NOT NULL,
    [Goods_ID] int  NOT NULL
);
GO

-- Creating table 'EntitySet_GoodsItem'
CREATE TABLE [dbo].[EntitySet_GoodsItem] (
    [ItemID] nvarchar(max)  NOT NULL,
    [ProductionDate] nvarchar(max)  NOT NULL,
    [ExpiryDate] nvarchar(max)  NOT NULL,
    [ID] int  NOT NULL,
    [Goods_ID] int  NOT NULL,
    [Changed_ID] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'OrderBodySet'
ALTER TABLE [dbo].[OrderBodySet]
ADD CONSTRAINT [PK_OrderBodySet]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'OrderHeadSet'
ALTER TABLE [dbo].[OrderHeadSet]
ADD CONSTRAINT [PK_OrderHeadSet]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'EntitySet'
ALTER TABLE [dbo].[EntitySet]
ADD CONSTRAINT [PK_EntitySet]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'EntitySet_GoodsUnit'
ALTER TABLE [dbo].[EntitySet_GoodsUnit]
ADD CONSTRAINT [PK_EntitySet_GoodsUnit]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'EntitySet_Goods'
ALTER TABLE [dbo].[EntitySet_Goods]
ADD CONSTRAINT [PK_EntitySet_Goods]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'EntitySet_Brand'
ALTER TABLE [dbo].[EntitySet_Brand]
ADD CONSTRAINT [PK_EntitySet_Brand]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'EntitySet_Changed'
ALTER TABLE [dbo].[EntitySet_Changed]
ADD CONSTRAINT [PK_EntitySet_Changed]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'EntitySet_Price'
ALTER TABLE [dbo].[EntitySet_Price]
ADD CONSTRAINT [PK_EntitySet_Price]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'EntitySet_GoodsItem'
ALTER TABLE [dbo].[EntitySet_GoodsItem]
ADD CONSTRAINT [PK_EntitySet_GoodsItem]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [OrderHead_ID] in table 'OrderBodySet'
ALTER TABLE [dbo].[OrderBodySet]
ADD CONSTRAINT [FK_OrderHeadOrderBodySet]
    FOREIGN KEY ([OrderHead_ID])
    REFERENCES [dbo].[OrderHeadSet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderHeadOrderBodySet'
CREATE INDEX [IX_FK_OrderHeadOrderBodySet]
ON [dbo].[OrderBodySet]
    ([OrderHead_ID]);
GO

-- Creating foreign key on [Unit_ID] in table 'EntitySet_Goods'
ALTER TABLE [dbo].[EntitySet_Goods]
ADD CONSTRAINT [FK_GoodsUnitGoods]
    FOREIGN KEY ([Unit_ID])
    REFERENCES [dbo].[EntitySet_GoodsUnit]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GoodsUnitGoods'
CREATE INDEX [IX_FK_GoodsUnitGoods]
ON [dbo].[EntitySet_Goods]
    ([Unit_ID]);
GO

-- Creating foreign key on [Brand_ID] in table 'EntitySet_Goods'
ALTER TABLE [dbo].[EntitySet_Goods]
ADD CONSTRAINT [FK_BrandGoods]
    FOREIGN KEY ([Brand_ID])
    REFERENCES [dbo].[EntitySet_Brand]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_BrandGoods'
CREATE INDEX [IX_FK_BrandGoods]
ON [dbo].[EntitySet_Goods]
    ([Brand_ID]);
GO

-- Creating foreign key on [Goods_ID] in table 'EntitySet_Changed'
ALTER TABLE [dbo].[EntitySet_Changed]
ADD CONSTRAINT [FK_GoodsChanged]
    FOREIGN KEY ([Goods_ID])
    REFERENCES [dbo].[EntitySet_Goods]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GoodsChanged'
CREATE INDEX [IX_FK_GoodsChanged]
ON [dbo].[EntitySet_Changed]
    ([Goods_ID]);
GO

-- Creating foreign key on [RootBrand_ID] in table 'EntitySet_Brand'
ALTER TABLE [dbo].[EntitySet_Brand]
ADD CONSTRAINT [FK_BrandBrand]
    FOREIGN KEY ([RootBrand_ID])
    REFERENCES [dbo].[EntitySet_Brand]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_BrandBrand'
CREATE INDEX [IX_FK_BrandBrand]
ON [dbo].[EntitySet_Brand]
    ([RootBrand_ID]);
GO

-- Creating foreign key on [Goods_ID] in table 'EntitySet_Price'
ALTER TABLE [dbo].[EntitySet_Price]
ADD CONSTRAINT [FK_PriceGoods]
    FOREIGN KEY ([Goods_ID])
    REFERENCES [dbo].[EntitySet_Goods]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_PriceGoods'
CREATE INDEX [IX_FK_PriceGoods]
ON [dbo].[EntitySet_Price]
    ([Goods_ID]);
GO

-- Creating foreign key on [Goods_ID] in table 'EntitySet_GoodsItem'
ALTER TABLE [dbo].[EntitySet_GoodsItem]
ADD CONSTRAINT [FK_GoodsGoodsItem]
    FOREIGN KEY ([Goods_ID])
    REFERENCES [dbo].[EntitySet_Goods]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GoodsGoodsItem'
CREATE INDEX [IX_FK_GoodsGoodsItem]
ON [dbo].[EntitySet_GoodsItem]
    ([Goods_ID]);
GO

-- Creating foreign key on [Changed_ID] in table 'EntitySet_GoodsItem'
ALTER TABLE [dbo].[EntitySet_GoodsItem]
ADD CONSTRAINT [FK_ChangedGoodsItem]
    FOREIGN KEY ([Changed_ID])
    REFERENCES [dbo].[EntitySet_Changed]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ChangedGoodsItem'
CREATE INDEX [IX_FK_ChangedGoodsItem]
ON [dbo].[EntitySet_GoodsItem]
    ([Changed_ID]);
GO

-- Creating foreign key on [ID] in table 'EntitySet_GoodsUnit'
ALTER TABLE [dbo].[EntitySet_GoodsUnit]
ADD CONSTRAINT [FK_GoodsUnit_inherits_Entity]
    FOREIGN KEY ([ID])
    REFERENCES [dbo].[EntitySet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [ID] in table 'EntitySet_Goods'
ALTER TABLE [dbo].[EntitySet_Goods]
ADD CONSTRAINT [FK_Goods_inherits_Entity]
    FOREIGN KEY ([ID])
    REFERENCES [dbo].[EntitySet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [ID] in table 'EntitySet_Brand'
ALTER TABLE [dbo].[EntitySet_Brand]
ADD CONSTRAINT [FK_Brand_inherits_Entity]
    FOREIGN KEY ([ID])
    REFERENCES [dbo].[EntitySet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [ID] in table 'EntitySet_Changed'
ALTER TABLE [dbo].[EntitySet_Changed]
ADD CONSTRAINT [FK_Changed_inherits_Entity]
    FOREIGN KEY ([ID])
    REFERENCES [dbo].[EntitySet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [ID] in table 'EntitySet_Price'
ALTER TABLE [dbo].[EntitySet_Price]
ADD CONSTRAINT [FK_Price_inherits_Entity]
    FOREIGN KEY ([ID])
    REFERENCES [dbo].[EntitySet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [ID] in table 'EntitySet_GoodsItem'
ALTER TABLE [dbo].[EntitySet_GoodsItem]
ADD CONSTRAINT [FK_GoodsItem_inherits_Entity]
    FOREIGN KEY ([ID])
    REFERENCES [dbo].[EntitySet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------