/*
The Annual NCAA March Madness Tournament Has Recently Concluded And Were Left With A 
Ton of Unanswered Questions Such as Who Performed The Best as a Team & as a Player?, Where 
Will The Players Fit Best In A NBA Roster? and etc. With that being said, MYSQL  Database aims 
to give clarity to some of these questions, successfully highlighting the relationships between
Player Performance and NBA Draft Predictions. Lets put on our NBA Scout Caps and get Started 

*/

CREATE TABLE players(
    player_id INT AUTO_INCREMENT PRIMARY KEY, 
    team VARCHAR(20), 
    position VARCHAR(1) NOT NULL, 
    first_name VARCHAR(20) NOT NULL, 
    last_name VARCHAR(20) NOT NULL, 
    points DECIMAL(2,1) NOT NULL, 
    rebounds DECIMAL(2,1) NOT NULL, 
    assist DECIMAL(2,1) NOT NULL,
    steal DECIMAL(2,1) NOT NULL, 
    blocks DECIMAL(2,1) NOT NULL, 
    turnovers DECIMAL(2,1) NOT NULL, 
    fieldgoalp DECIMAL(2,1) NOT NULL,
    freethrowp DECIMAL(2,1) NOT NULL,
    threepointp DECIMAL(2,1) NOT NULL
);

INSERT INTO players VALUES
('miami','G','Isaiah', 'Wong', 16.2,4.3,3.2,1.4,0.4,2.1,44.5,84.5,38.4)
('miami', 'G','Jordan', 'Miller',15.3, 6.2, 2.7, 1.2, 0.4, 1.3, 54.5, 78.4, 35.2),
('miami','G','Nijel','Pack',13.6, 2.7, 2.3, 1.0, 0.2, 1.7, 44.1, 88.2, 40.4),
('miami','F','Norchad', 'Omier',13.1, 10.0, 1.3, 1.1, 1.1, 1.9, 57.4, 73.6, 31.3),
('miami','G','Wooga', 'Poplar', 8.4, 3.3, 1.5, 1.1, 0.2, 1.2, 47.0, 86.7, 37.5),
('uconn','F','Adama', 'Sanogo', 17.2, 7.7, 1.3, 0.7, 0.8, 1.9, 60.6, 76.6, 36.5),
('uconn','G','Jordan', 'Hawkins', 16.2, 3.8, 1.3, 0.7, 0.5, 1.4, 40.9, 88.7, 38.8),
('uconn','G','Tristen', 'Newton', 10.1, 4.5, 4.7, 1.1, 0.3, 2.4, 37.4, 81.6, 36.6),
('uconn','F','Alex', 'Karaban', 9.3, 4.5, 1.7, 0.5, 0.7, 1.2, 47.6, 80.9, 40.2),
('uconn','C','Donovan', 'Clingan',6.9, 5.6, 0.5, 0.4, 1.8, 1.0, 65.5, 51.7, 0.0),
('fl-atlantic','G','Johnel','Davis',13.8, 5.4, 1.6, 1.5, 0.1, 1.8, 48.6, 85.5, 35.7),
('fl-atlantic','G','Alijah','Martin',13.4, 5.3, 1.4, 1.0, 0.3, 1.7, 43.8, 78.8, 37.2),
('fl-atlantic','C','Vladislav','Goldin',10.2, 6.5, 0.4, 0.4, 1.2, 1.3, 62.5, 59.1, 0.0),
('fl-atlantic','G','Nicholas','Boyd', 8.9, 4.3, 2.4, 0.8, 0.0, 1.1, 44.9, 62.2, 40.0),
('fl-atlantic','G','Michael','Forrest', 8.2, 2.2, 1.6, 0.6, 0.1, 1.0, 40.5, 75.5, 34.0),
('sandiego','G','Matt','Bradley', 12.6, 3.8, 2.1, 0.7, 0.3, 1.4, 39.8, 80.0, 35.6),
('sandiego','G','Darrion','Trammell', 9.8, 2.4, 2.9, 1.3, 0.1, 1.6, 36.2, 74.0, 31.4),
('sandiego','G','Lamont','Butler', 8.8, 2.7, 3.2, 1.5, 0.1, 2.0, 42.1, 73.1, 34.2),
('sandiego','F','Jaedon','LeDee', 7.9, 5.3, 0.9, 0.5, 0.4, 1.0, 48.9, 72.8, 0.0),
('sandiego','F','Keshad','Johnson', 7.7, 5.0, 0.7, 0.5, 0.4, 0.8, 53.2, 64.8, 26.2);

--Find The Top 5 Shooters  
SELECT team,position,first_name,last_name,points,fieldgoalp,threepointp FROM players ORDER BY threepointp DESC LIMIT 5;

-- Find Highest Scoring Guard  

SELECT team,first_name,last_name,points FROM players 
WHERE position = 'G' ORDER BY points DESC LIMIT 1; 

--Find Highest Scoring Forward  

SELECT team,first_name,last_name,points FROM players 
WHERE position = 'F' ORDER BY points DESC LIMIT 1; 

--Find Most Efficient Player 

SELECT team,first_name,last_name,points,fieldgoalp FROM players 
WHERE fieldgoalp IN (SELECT MAX(fieldgoalp) FROM players) AND points > 10; 

-- Worst Guard On UConn 

SELECT team,position,first_name,last_name FROM players 
WHERE team LIKE '%uconn%' AND position = 'G' ORDER BY fieldgoalp ASC LIMIT 1; 

-- Total Team PPG 

SELECT team, SUM(points) AS total_pts FROM players GROUP BY team ; 

-- Create NBA Table 

CREATE TABLE nba(
team VARCHAR(55) UNIQUE, 
pos_interest VARCHAR(3) PRIMARY KEY, 
req_points DECIMAL(3,1), 
req_assist DECIMAL(3,1), 
req_blocks DECIMAL(3,1), 
req_rebounds DECIMAL(3,1),  
req_fieldgoalp DECIMAL(3,1), 
req_threepointp DECIMAL(3,1) 
);

INSERT INTO nba VALUES
('Golden State Warriors', 'G',10,1,0.3,3,30,30),
('Los Angeles Lakers', 'C', null,null,1,5,null,null),
('Brooklyn Nets', 'F',12,null,1,5,25,null); 
 
ALTER TABLE players ADD CONSTRAINT fk_pos 
FOREIGN KEY (position) REFERENCES nba(pos_interest); 

-- Find Lakers A Center! 

SELECT position,first_name,last_name,blocks,rebounds,nba.team,nba.pos_interest FROM players
INNER JOIN nba ON players.position = nba.pos_interest 
WHERE players.position='C' AND players.blocks > nba.req_blocks
AND players.rebounds > nba.req_rebounds; 

-- 5  Viable Picks For Golden State 

SELECT position,first_name,last_name,points,nba.team,nba.pos_interest FROM players 
INNER JOIN nba ON players.position = nba.pos_interest WHERE position = 'G' AND 
players.points > nba.req_points LIMIT 5;
 



-- Find Best Scorers In Entire Data Set 

SELECT * FROM players WHERE points > 10 AND fieldgoalp BETWEEN 30 AND 100; 

