CREATE TABLE PersonCredentials(
    USERID INT NOT NULL GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    EMAIL VARCHAR(255) NOT NULL UNIQUE,
    PASSWORD VARCHAR(255) NOT NULL,
    PRIMARY KEY(USERID)
);

CREATE TABLE PersonInfo(
    USERID INT NOT NULL,
    FNAME VARCHAR(50) NOT NULL,
    MNAME VARCHAR(50),
    LNAME VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    PRIMARY KEY(USERID),
    FOREIGN KEY(USERID) REFERENCES PersonCredentials(USERID) ON DELETE CASCADE
);

CREATE TABLE PaymentMethods(
    PaymentType INT NOT NULL GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    PaymentName VARCHAR(50) NOT NULL,
    PRIMARY KEY(PaymentType)
);
INSERT INTO PaymentMethods (PaymentName) VALUES('Credit Card');
INSERT INTO PaymentMethods (PaymentName) VALUES('Globe GCash');

CREATE TABLE UserPaymentMethods(
    PMIdentifier VARCHAR(255) NOT NULL,
    PaymentType INT NOT NULL,
    USERID INT NOT NULL,
    FOREIGN KEY(PaymentType) REFERENCES PaymentMethods(PaymentType) ON DELETE CASCADE,
    FOREIGN KEY(USERID) REFERENCES PersonCredentials(USERID) ON DELETE CASCADE,
    PRIMARY KEY(PMIdentifier)
);

CREATE TABLE GCashInfo(
    USERID INT NOT NULL,
    PMIdentifier VARCHAR(255) NOT NULL,
    GCashNumber VARCHAR(10) NOT NULL,
    FOREIGN KEY(USERID) REFERENCES PersonCredentials(USERID) ON DELETE CASCADE,
    FOREIGN KEY(PMIdentifier) REFERENCES UserPaymentMethods(PMIdentifier) ON DELETE CASCADE,
    PRIMARY KEY(USERID,PMIdentifier)
);

CREATE TABLE SupportedCC(
    CCType SMALLINT NOT NULL GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    CCName VarCHAR(25) NOT NULL,
    Primary key (CCType)
);
INSERT INTO SupportedCC (CCName) VALUES('Visa');
INSERT INTO SupportedCC (CCName) VALUES('MasterCard');

CREATE TABLE CCardInfo(
    USERID INT NOT NULL,
    PMIdentifier VARCHAR(255) NOT NULL,
    CCType SMALLINT NOT NULL,
    CCNumber VARCHAR(255) NOT NULL,
    CCFName VarChar(50) NOT NULL,
    CCLName VarChar(50) NOT NULL,
    CCValidDate Date NOT NULL,
    FOREIGN KEY(USERID) REFERENCES PersonCredentials(USERID) ON DELETE CASCADE,
    FOREIGN KEY(PMIdentifier) REFERENCES UserPaymentMethods(PMIdentifier) ON DELETE CASCADE,
    FOREIGN KEY(CCType) REFERENCES SupportedCC(CCType) ON DELETE CASCADE,
    PRIMARY KEY(USERID,PMIdentifier)
);

CREATE TABLE SupportedGames(
    GameID INT NOT NULL GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    GameName VarChar(64) NOT NULL,
    GamePage VarChar(128) NOT NULL,
    PRIMARY KEY(GameID)
);
INSERT INTO SupportedGames (GameName, GamePage) VALUES('Genshin Impact','games/genshin-impact.jsp');
INSERT INTO SupportedGames (GameName, GamePage) VALUES('Honkai Star Rail','games/hsr.jsp');
INSERT INTO SupportedGames (GameName, GamePage) VALUES('Valorant','games/riot-valorant.jsp');

CREATE TABLE INVENTORY(
    ItemID VARCHAR(255) NOT NULL,
    GameID INT NOT NULL,
    ItemName VARCHAR(128) NOT NULL,
    ItemPic VARCHAR(128) NOT NULL,
    ItemValue INT NOT NULL,
    FOREIGN KEY(GameID) REFERENCES SupportedGames(GameID) ON DELETE CASCADE,
    UNIQUE(ItemID, GameID),
    PRIMARY KEY(ItemID)
);

CREATE TABLE UserTransactions(
    UserID INT NOT NULL,
    TransactionID VARCHAR(192) NOT NULL,
    PaymentType INT NOT NULL,
    PMIdentifier VARCHAR(255) NOT NULL,
    TransactionDate DATE NOT NULL,
    FOREIGN KEY(UserID) REFERENCES PersonCredentials(UserID) ON DELETE CASCADE,
    FOREIGN KEY(PaymentType) REFERENCES PaymentMethods(PaymentType) ON DELETE CASCADE,
    FOREIGN KEY(PMIdentifier) REFERENCES UserPaymentMethods(PMIdentifier)  ON DELETE CASCADE,
    PRIMARY KEY(TransactionID),
    UNIQUE(USERID, TransactionID)
);

CREATE TABLE TransactionInfo(
    TransactionID VARCHAR(192) NOT NULL,
    ItemID VARCHAR(255) NOT NULL,
    ItemRecipient VARCHAR(192) NOT NULL,
    Foreign Key(TransactionID) references UserTransactions(TransactionID),
    Foreign Key(ItemID) references INVENTORY(ItemID),
    PRIMARY KEY(TransactionID)
);