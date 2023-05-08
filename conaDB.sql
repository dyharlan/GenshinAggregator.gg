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
    GameIcon VarChar(1024) NOT NULL,
    GamePage VarChar(128) NOT NULL,
    PRIMARY KEY(GameID)
);
INSERT INTO SupportedGames (GameName, GameIcon, GamePage) VALUES('Genshin Impact', 'https://play-lh.googleusercontent.com/vRd2gg6XmC3TRTM5wZZ8qwEc5LMUROh4whycLuiCSPB40tIxDYLT6V0BdCn486XiKQ0=w240-h480-rw' ,'games/genshin-impact.jsp');
INSERT INTO SupportedGames (GameName, GameIcon, GamePage) VALUES('Honkai Star Rail', 'https://cdn.now.gg/apps-content/com.HoYoverse.hkrpgoversea/icon/honkai-star-rail.png' ,'games/hsr.jsp');
INSERT INTO SupportedGames (GameName, GameIcon, GamePage) VALUES('Valorant','https://www.techspot.com/images2/downloads/topdownload/2020/06/2020-06-09-ts3_thumbs-7fd.png','games/riot-valorant.jsp');

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