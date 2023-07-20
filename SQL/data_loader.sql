CREATE DATABASE IF NOT EXISTS baseballdb;
USE baseballdb;
SET GLOBAL local_infile=1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

DROP TABLE IF EXISTS People;
CREATE TABLE People (
  playerID varchar(255) NOT NULL,
  birthYear int DEFAULT NULL,
  birthMonth int DEFAULT NULL,
  birthDay int DEFAULT NULL,
  birthCountry varchar(255) DEFAULT NULL,
  birthState varchar(255) DEFAULT NULL,
  birthCity varchar(255) DEFAULT NULL,
  deathYear int DEFAULT NULL,
  deathMonth int DEFAULT NULL,
  deathDay int DEFAULT NULL,
  deathCountry varchar(255) DEFAULT NULL,
  deathState varchar(255) DEFAULT NULL,
  deathCity varchar(255) DEFAULT NULL,
  nameFirst varchar(255) DEFAULT NULL,
  nameLast varchar(255) DEFAULT NULL,
  nameGiven varchar(255) DEFAULT NULL,
  weight int DEFAULT NULL,
  height int DEFAULT NULL,
  bats varchar(255) DEFAULT NULL,
  throws varchar(255) DEFAULT NULL,
  debut varchar(255) DEFAULT NULL,
  finalGame varchar(255) DEFAULT NULL,
  retroID varchar(255) DEFAULT NULL,
  bbrefID varchar(255) DEFAULT NULL,
  PRIMARY KEY (playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\People.csv'
INTO TABLE People
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Batting;
CREATE TABLE Batting (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  stint int NOT NULL,
  teamID varchar(255) DEFAULT NULL,
  lgID varchar(255) DEFAULT NULL,
  G int DEFAULT NULL,
  G_batting int DEFAULT NULL,
  AB int DEFAULT NULL,
  R int DEFAULT NULL,
  H int DEFAULT NULL,
  2B int DEFAULT NULL,
  3B int DEFAULT NULL,
  HR int DEFAULT NULL,
  RBI int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  IBB int DEFAULT NULL,
  HBP int DEFAULT NULL,
  SH int DEFAULT NULL,
  SF int DEFAULT NULL,
  GIDP int DEFAULT NULL
  -- UNIQUE KEY (playerID,yearID,stint),
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\Batting.csv'
INTO TABLE Batting
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Pitching;
CREATE TABLE Pitching (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  stint int NOT NULL,
  teamID varchar(255) DEFAULT NULL,
  lgID varchar(255) DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  CG int DEFAULT NULL,
  SHO int DEFAULT NULL,
  SV int DEFAULT NULL,
  IPouts int DEFAULT NULL,
  H int DEFAULT NULL,
  ER int DEFAULT NULL,
  HR int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  BAOpp double DEFAULT NULL,
  ERA double DEFAULT NULL,
  IBB int DEFAULT NULL,
  WP int DEFAULT NULL,
  HBP int DEFAULT NULL,
  BK int DEFAULT NULL,
  BFP int DEFAULT NULL,
  GF int DEFAULT NULL,
  R int DEFAULT NULL,
  SH int DEFAULT NULL,
  SF int DEFAULT NULL,
  GIDP int DEFAULT NULL
  -- UNIQUE KEY (playerID,yearID,stint),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\Pitching.csv'
INTO TABLE Pitching
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Fielding;
CREATE TABLE Fielding (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  stint int NOT NULL,
  teamID varchar(255) DEFAULT NULL,
  lgID varchar(255) DEFAULT NULL,
  POS varchar(255) NOT NULL,
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  InnOuts int DEFAULT NULL,
  PO int DEFAULT NULL,
  A int DEFAULT NULL,
  E int DEFAULT NULL,
  DP int DEFAULT NULL,
  PB int DEFAULT NULL,
  WP int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  ZR double DEFAULT NULL
  -- UNIQUE KEY (playerID,yearID,stint,POS),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\Fielding.csv'
INTO TABLE Fielding
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS AllStarFull;
CREATE TABLE AllStarFull (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  gameNum int NOT NULL,
  gameID varchar(255) DEFAULT NULL,
  teamID varchar(255) DEFAULT NULL,
  lgID varchar(255) DEFAULT NULL,
  GP int DEFAULT NULL,
  startingPos int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (playerID,yearID,gameNum,gameID,lgID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES team-- s(ID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\AllStarFull.csv'
INTO TABLE AllStarFull
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS HallOfFame;
CREATE TABLE HallOfFame (
  playerID varchar(255) NOT NULL,
  yearid int NOT NULL,
  votedBy varchar(255) NOT NULL,
  ballots int DEFAULT NULL,
  needed int DEFAULT NULL,
  votes int DEFAULT NULL,
  inducted varchar(255) DEFAULT NULL,
  category varchar(255)DEFAULT NULL,
  needed_note varchar(255)DEFAULT NULL
  -- PRIMARY KEY (ID),  
  -- UNIQUE KEY (playerID,yearid,votedBy),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\contrib\\HallOfFame.csv'
INTO TABLE HallOfFame
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Managers;
CREATE TABLE Managers (
  playerID varchar(255)DEFAULT NULL,
  yearID int NOT NULL,
  teamID varchar(255) NOT NULL,
  lgID varchar(255) DEFAULT NULL,
  inseason int NOT NULL,
  G int DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  `rank` int DEFAULT NULL,
  plyrMgr varchar(255) DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (yearID,teamID,inseason),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\Managers.csv'
INTO TABLE Managers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Teams;
CREATE TABLE Teams (
  yearID int NOT NULL,
  lgID varchar(255) DEFAULT NULL,
  teamID varchar(255) NOT NULL,
  franchID varchar(255) DEFAULT NULL,
  divID varchar(255) DEFAULT NULL,
  `rank` int DEFAULT NULL,
  G int DEFAULT NULL,
  Ghome int DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  DivWin varchar(255) DEFAULT NULL,
  WCWin varchar(255) DEFAULT NULL,
  LgWin varchar(255) DEFAULT NULL,
  WSWin varchar(255) DEFAULT NULL,
  R int DEFAULT NULL,
  AB int DEFAULT NULL,
  H int DEFAULT NULL,
  2B int DEFAULT NULL,
  3B int DEFAULT NULL,
  HR int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  HBP int DEFAULT NULL,
  SF int DEFAULT NULL,
  RA int DEFAULT NULL,
  ER int DEFAULT NULL,
  ERA double DEFAULT NULL,
  CG int DEFAULT NULL,
  SHO int DEFAULT NULL,
  SV int DEFAULT NULL,
  IPouts int DEFAULT NULL,
  HA int DEFAULT NULL,
  HRA int DEFAULT NULL,
  BBA int DEFAULT NULL,
  SOA int DEFAULT NULL,
  E int DEFAULT NULL,
  DP int DEFAULT NULL,
  FP double DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  park varchar(255) DEFAULT NULL,
  attendance int DEFAULT NULL,
  BPF int DEFAULT NULL,
  PPF int DEFAULT NULL,
  teamIDBR varchar(255) DEFAULT NULL,
  teamIDlahman45 varchar(255) DEFAULT NULL,
  teamIDretro varchar(255) DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (yearID,lgID,teamID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (div_ID) REFERENCES divisions(ID),
  -- FOREIGN KEY (franchID) REFERENCES teamsfranchises(franchID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\Teams.csv'
INTO TABLE Teams
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS BattingPost;
CREATE TABLE BattingPost (
  yearID int NOT NULL,
  `round` varchar(255) NOT NULL,
  playerID varchar(255) NOT NULL,
  teamID varchar(255) DEFAULT NULL,
  lgID varchar(255) DEFAULT NULL,
  G int DEFAULT NULL,
  AB int DEFAULT NULL,
  R int DEFAULT NULL,
  H int DEFAULT NULL,
  2B int DEFAULT NULL,
  3B int DEFAULT NULL,
  HR int DEFAULT NULL,
  RBI int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  IBB int DEFAULT NULL,
  HBP int DEFAULT NULL,
  SH int DEFAULT NULL,
  SF int DEFAULT NULL,
  GIDP int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (yearID,round,playerID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\BattingPost.csv'
INTO TABLE BattingPost
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS PitchingPost;
CREATE TABLE PitchingPost (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  `round` varchar(255) NOT NULL,
  teamID varchar(255) DEFAULT NULL,
  lgID varchar(255) DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  CG int DEFAULT NULL,
  SHO int DEFAULT NULL,
  SV int DEFAULT NULL,
  IPouts int DEFAULT NULL,
  H int DEFAULT NULL,
  ER int DEFAULT NULL,
  HR int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  BAOpp double DEFAULT NULL,
  ERA double DEFAULT NULL,
  IBB int DEFAULT NULL,
  WP int DEFAULT NULL,
  HBP int DEFAULT NULL,
  BK int DEFAULT NULL,
  BFP int DEFAULT NULL,
  GF int DEFAULT NULL,
  R int DEFAULT NULL,
  SH int DEFAULT NULL,
  SF int DEFAULT NULL,
  GIDP int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (playerID,yearID,round),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\PitchingPost.csv'
INTO TABLE PitchingPost
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS TeamsFranchises;
CREATE TABLE TeamsFranchises (
  franchID varchar(255) NOT NULL,
  franchName varchar(255) DEFAULT NULL,
  active char DEFAULT NULL,
  NAassoc varchar(255) DEFAULT NULL
  -- PRIMARY KEY (franchID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\TeamsFranchises.csv'
INTO TABLE TeamsFranchises
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS FieldingOF;
CREATE TABLE FieldingOF (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  stint int NOT NULL,
  Glf int DEFAULT NULL,
  Gcf int DEFAULT NULL,
  Grf int DEFAULT NULL
  -- PRIMARY KEY (ID),  
  -- UNIQUE KEY (playerID,yearID,stint),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\FIeldingOF.csv'
INTO TABLE FieldingOF
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS ManagersHalf;
CREATE TABLE ManagersHalf (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  teamID varchar(255) NOT NULL,
  lgID varchar(255) DEFAULT NULL,
  inseason int DEFAULT NULL,
  half int NOT NULL,
  G int DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  `rank` int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (playerID,yearID,teamID,half),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\ManagersHalf.csv'
INTO TABLE ManagersHalf
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS TeamsHalf;
CREATE TABLE TeamsHalf (
  yearID int NOT NULL,
  lgID varchar(255) NOT NULL,
  teamID varchar(255) NOT NULL,
  half varchar(255) NOT NULL,
  divID varchar(255) DEFAULT NULL,
  DivWin varchar(255) DEFAULT NULL,
  `rank` int DEFAULT NULL,
  G int DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (yearID,lgID,teamID,Half),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (div_ID) REFERENCES divisions(ID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES team-- s(ID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\TeamsHalf.csv'
INTO TABLE TeamsHalf
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Salaries;
CREATE TABLE Salaries (
  yearID int NOT NULL,
  teamID varchar(255) NOT NULL,
  lgID varchar(255) NOT NULL,
  playerID varchar(255) NOT NULL,
  salary double DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (yearID,teamID,lgID,playerID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\contrib\\Salaries.csv'
INTO TABLE Salaries
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS SeriesPost;
CREATE TABLE SeriesPost (
  yearID int NOT NULL,
  round varchar(255) NOT NULL,
  teamIDwinner varchar(255) DEFAULT NULL,
  lgIDwinner varchar(255) DEFAULT NULL,
  teamIDloser varchar(255) DEFAULT NULL,
  lgIDloser varchar(255) DEFAULT NULL,
  wins int DEFAULT NULL,
  losses int DEFAULT NULL,
  ties int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (yearID,round),
  -- FOREIGN KEY (lgIDwinner) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (lgIDloser) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_IDwinner) REFERENCES teams(ID),
  -- FOREIGN KEY (team_IDloser) REFERENCES teams(ID)-- 
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\SeriesPost.csv'
INTO TABLE SeriesPost
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS AwardsManagers;
CREATE TABLE awardsmanagers (
  playerID varchar(255) NOT NULL,
  awardID varchar(255) NOT NULL,
  yearID int NOT NULL,
  lgID varchar(255) NOT NULL,
  tie varchar(255) DEFAULT NULL,
  notes varchar(255) DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (playerID,awardID,yearID,lgID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\contrib\\AwardsManagers.csv'
INTO TABLE AwardsManagers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS AwardsPlayers;
CREATE TABLE AwardsPlayers (
  playerID varchar(255) NOT NULL,
  awardID varchar(255) NOT NULL,
  yearID int NOT NULL,
  lgID varchar(255) NOT NULL,
  tie varchar(255) DEFAULT NULL,
  notes varchar(255) DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (playerID,awardID,yearID,lgID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\contrib\\AwardsPlayers.csv'
INTO TABLE AwardsPlayers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS AwardsShareManagers;
CREATE TABLE AwardsShareManagers (
  awardID varchar(255) NOT NULL,
  yearID int NOT NULL,
  lgID varchar(255) NOT NULL,
  playerID varchar(255) NOT NULL,
  pointsWon int DEFAULT NULL,
  pointsMax int DEFAULT NULL,
  votesFirst int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (playerID,awardID,yearID,lgID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\contrib\\AwardsShareManagers.csv'
INTO TABLE AwardsShareManagers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS AwardsSharePlayers;
CREATE TABLE AwardsSharePlayers (
  awardID varchar(255) NOT NULL,
  yearID int NOT NULL,
  lgID varchar(255) NOT NULL,
  playerID varchar(255) NOT NULL,
  pointsWon double DEFAULT NULL,
  pointsMax int DEFAULT NULL,
  votesFirst double DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (playerID,awardID,yearID,lgID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\contrib\\AwardsSharePlayers.csv'
INTO TABLE AwardsSharePlayers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS FieldingPost;
CREATE TABLE FieldingPost (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  teamID varchar(255) DEFAULT NULL,
  lgID varchar(255) DEFAULT NULL,
  round varchar(255) NOT NULL,
  POS varchar(255) NOT NULL,
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  InnOuts int DEFAULT NULL,
  PO int DEFAULT NULL,
  A int DEFAULT NULL,
  E int DEFAULT NULL,
  DP int DEFAULT NULL,
  TP int DEFAULT NULL,
  PB int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL
  -- PRIMARY KEY (ID),  
  -- UNIQUE KEY (playerID,yearID,round,POS),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\FieldingPost.csv'
INTO TABLE FieldingPost
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Appearances;
CREATE TABLE Appearances (
  yearID int NOT NULL,
  teamID varchar(255) NOT NULL,
  lgID varchar(255) DEFAULT NULL,
  playerID varchar(255) NOT NULL,
  G_all int DEFAULT NULL,
  GS int DEFAULT NULL,
  G_batting int DEFAULT NULL,
  G_defense int DEFAULT NULL,
  G_p int DEFAULT NULL,
  G_c int DEFAULT NULL,
  G_1b int DEFAULT NULL,
  G_2b int DEFAULT NULL,
  G_3b int DEFAULT NULL,
  G_ss int DEFAULT NULL,
  G_lf int DEFAULT NULL,
  G_cf int DEFAULT NULL,
  G_rf int DEFAULT NULL,
  G_of int DEFAULT NULL,
  G_dh int DEFAULT NULL,
  G_ph int DEFAULT NULL,
  G_pr int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- UNIQUE KEY (yearID,teamID,playerID),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\Appearances.csv'
INTO TABLE Appearances
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Schools;
CREATE TABLE Schools (
  schoolID varchar(255) NOT NULL,
  name_full varchar(255) DEFAULT NULL,
  city varchar(255)DEFAULT NULL,
  state varchar(255)DEFAULT NULL,
  country varchar(255)DEFAULT NULL
  -- PRIMARY KEY (schoolID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\contrib\\Schools.csv'
INTO TABLE Schools
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS CollegePlaying;
CREATE TABLE CollegePlaying (
  playerID varchar(255) NOT NULL,
  schoolID varchar(255) DEFAULT NULL,
  yearID int DEFAULT NULL
  -- PRIMARY KEY (ID),  
  -- FOREIGN KEY (schoolID) REFERENCES schools(schoolID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\contrib\\CollegePlaying.csv'
INTO TABLE CollegePlaying
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS FieldingOfSplit;
CREATE TABLE FieldingOfSplit (
  playerID varchar(255) NOT NULL,
  yearID int NOT NULL,
  stint int NOT NULL,
  teamID varchar(255) DEFAULT NULL,
  lgID varchar(255) DEFAULT NULL,
  POS varchar(255) NOT NULL,
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  InnOuts int DEFAULT NULL,
  PO int DEFAULT NULL,
  A int DEFAULT NULL,
  E int DEFAULT NULL,
  DP int DEFAULT NULL,
  PB int DEFAULT NULL,
  WP int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  ZR double DEFAULT NULL
  -- PRIMARY KEY (ID),  
  -- UNIQUE KEY (playerID,yearID,stint,POS),
  -- FOREIGN KEY (lgID) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (playerID) REFERENCES people(playerID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\FieldingOfSplit.csv'
INTO TABLE FieldingOfSplit
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS Parks;
CREATE TABLE Parks (
  parkkey varchar(255) DEFAULT NULL,
  parkname varchar(255) DEFAULT NULL,
  parkalias varchar(255) DEFAULT NULL,
  city varchar(255) DEFAULT NULL,
  state varchar(255) DEFAULT NULL,
  country varchar(255) DEFAULT NULL
  -- PRIMARY KEY (ID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\Parks.csv'
INTO TABLE Parks
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS HomeGames;
CREATE TABLE HomeGames (
  yearkey int DEFAULT NULL,
  leaguekey varchar(255) DEFAULT NULL,
  teamkey varchar(255) DEFAULT NULL,
  parkkey varchar(255) DEFAULT NULL,
  spanfirst varchar(255) DEFAULT NULL,
  spanlast varchar(255) DEFAULT NULL,
  games int DEFAULT NULL,
  openings int DEFAULT NULL,
  attendance int DEFAULT NULL
  -- PRIMARY KEY (ID),
  -- FOREIGN KEY (leaguekey) REFERENCES leagues(lgID), /* Not normalized, but keeping to maintain consistency with original */
  -- FOREIGN KEY (team_ID) REFERENCES teams(ID),
  -- FOREIGN KEY (park_ID) REFERENCES park-- s(ID)
);

LOAD DATA LOCAL INFILE 'baseballdatabank-2022.2\\core\\HomeGames.csv'
INTO TABLE HomeGames
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
