
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 08/03/2012 09:20:29
-- Generated from EDMX file: C:\Users\Irvin\Documents\GitHub\tts\src\LogicLibary\StoreDb.edmx
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
IF OBJECT_ID(N'[dbo].[FK_BrandInBrand]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BrandSet] DROP CONSTRAINT [FK_BrandInBrand];
GO
IF OBJECT_ID(N'[dbo].[FK_GoodsUnitGoods]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GoodsSet] DROP CONSTRAINT [FK_GoodsUnitGoods];
GO
IF OBJECT_ID(N'[dbo].[FK_BrandGoods]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GoodsSet] DROP CONSTRAINT [FK_BrandGoods];
GO
IF OBJECT_ID(N'[dbo].[FK_GoodsChanged]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ChangedSet] DROP CONSTRAINT [FK_GoodsChanged];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[GoodsSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GoodsSet];
GO
IF OBJECT_ID(N'[dbo].[GoodsUnitSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GoodsUnitSet];
GO
IF OBJECT_ID(N'[dbo].[OrderBodySet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderBodySet];
GO
IF OBJECT_ID(N'[dbo].[OrderHeadSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderHeadSet];
GO
IF OBJECT_ID(N'[dbo].[BrandSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BrandSet];
GO
IF OBJECT_ID(N'[dbo].[ChangedSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ChangedSet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'GoodsSet'
CREATE TABLE [dbo].[GoodsSet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [GoodsName] nvarchar(50)  NOT NULL,
    [Quantity] float  NOT NULL,
    [UserKey] nvarchar(max)  NOT NULL,
    [Modified] datetime  NOT NULL,
    [Enable] bit  NOT NULL,
    [Unit_ID] int  NOT NULL,
    [Brand_ID] int  NOT NULL
);
GO

-- Creating table 'GoodsUnitSet'
CREATE TABLE [dbo].[GoodsUnitSet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [UnitName] nvarchar(max)  NOT NULL,
    [UserKey] nvarchar(36)  NOT NULL,
    [Modified] datetime  NOT NULL,
    [Enable] bit  NOT NULL
);
GO

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

-- Creating table 'BrandSet'
CREATE TABLE [dbo].[BrandSet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [BrandName] nvarchar(max)  NOT NULL,
    [UserKey] nvarchar(36)  NOT NULL,
    [Modified] datetime  NOT NULL,
    [RootBrand_ID] int  NULL
);
GO

-- Creating table 'ChangedSet'
CREATE TABLE [dbo].[ChangedSet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Value] float  NOT NULL,
    [Date] datetime  NOT NULL,
    [Quantity] float  NOT NULL,
    [UserKey] nvarchar(36)  NOT NULL,
    [Modified] datetime  NOT NULL,
    [Goods_ID] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'GoodsSet'
ALTER TABLE [dbo].[GoodsSet]
ADD CONSTRAINT [PK_GoodsSet]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'GoodsUnitSet'
ALTER TABLE [dbo].[GoodsUnitSet]
ADD CONSTRAINT [PK_GoodsUnitSet]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

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

-- Creating primary key on [ID] in table 'BrandSet'
ALTER TABLE [dbo].[BrandSet]
ADD CONSTRAINT [PK_BrandSet]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'ChangedSet'
ALTER TABLE [dbo].[ChangedSet]
ADD CONSTRAINT [PK_ChangedSet]
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

-- Creating foreign key on [RootBrand_ID] in table 'BrandSet'
ALTER TABLE [dbo].[BrandSet]
ADD CONSTRAINT [FK_BrandInBrand]
    FOREIGN KEY ([RootBrand_ID])
    REFERENCES [dbo].[BrandSet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_BrandInBrand'
CREATE INDEX [IX_FK_BrandInBrand]
ON [dbo].[BrandSet]
    ([RootBrand_ID]);
GO

-- Creating foreign key on [Unit_ID] in table 'GoodsSet'
ALTER TABLE [dbo].[GoodsSet]
ADD CONSTRAINT [FK_GoodsUnitGoods]
    FOREIGN KEY ([Unit_ID])
    REFERENCES [dbo].[GoodsUnitSet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GoodsUnitGoods'
CREATE INDEX [IX_FK_GoodsUnitGoods]
ON [dbo].[GoodsSet]
    ([Unit_ID]);
GO

-- Creating foreign key on [Brand_ID] in table 'GoodsSet'
ALTER TABLE [dbo].[GoodsSet]
ADD CONSTRAINT [FK_BrandGoods]
    FOREIGN KEY ([Brand_ID])
    REFERENCES [dbo].[BrandSet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_BrandGoods'
CREATE INDEX [IX_FK_BrandGoods]
ON [dbo].[GoodsSet]
    ([Brand_ID]);
GO

-- Creating foreign key on [Goods_ID] in table 'ChangedSet'
ALTER TABLE [dbo].[ChangedSet]
ADD CONSTRAINT [FK_GoodsChanged]
    FOREIGN KEY ([Goods_ID])
    REFERENCES [dbo].[GoodsSet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GoodsChanged'
CREATE INDEX [IX_FK_GoodsChanged]
ON [dbo].[ChangedSet]
    ([Goods_ID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------