DROP DATABASE IF EXISTS NYPL_Menus_raw;

CREATE DATABASE IF NOT EXISTS NYPL_Menus_raw;

USE NYPL_Menus_raw;

DROP TABLE IF EXISTS dish;

CREATE TABLE dish (
 id int NOT NULL PRIMARY KEY,
 name text,
 description text,
 menus_appeared int NOT NULL,
 times_appeared int NOT NULL,
 first_appeared int NOT NULL,
 last_appeared int NOT NULL,
 lowest_price float,
 highest_price float
);

LOAD DATA LOCAL INFILE '../Raw_Data/Dish.csv'
INTO TABLE dish 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

DROP TABLE IF EXISTS menu;

CREATE TABLE menu (
 id int NOT NULL PRIMARY KEY,
 name text,
 sponsor text,
 sponsor_cluster text,
 event text,
 event_cluster text,
 venue text,
 place text,
 place_cluster text,
 physical_description text,
 occasion text,
 notes text,
 call_number text,
 keywords text,
 language text,
 date date,
 location text,
 location_cluster text,
 location_type text,
 currency text,
 currency_symbol text,
 status text,
 page_count int,
 dish_count int
);

LOAD DATA LOCAL INFILE '../Raw_Data/Menu.csv'
INTO TABLE menu 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

DROP TABLE IF EXISTS menupage;

CREATE TABLE menupage (
    id int NOT NULL PRIMARY KEY,
    menu_id int NOT NULL,
    page_number int,
    image_id int,
    full_height float,
    full_width float,
    uuid text,
    FOREIGN KEY (menu_id) REFERENCES menu (id)
);


LOAD DATA LOCAL INFILE '../Raw_Data/MenuPage.csv'
INTO TABLE menupage 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;


DROP TABLE IF EXISTS menuItem;

CREATE TABLE menuItem (
 id int NOT NULL PRIMARY KEY,
 menu_page_id int NOT NULL,
 price float,
 high_price float,
 dish_id int NOT NULL,
 created_at datetime ,
 updated_at datetime,
 xpos float,
 ypos float,
 created_date datetime ,
 updated_date datetime,
 FOREIGN KEY (menu_page_id) REFERENCES menupage (id),
 FOREIGN KEY (dish_id) REFERENCES dish (id)
);


LOAD DATA LOCAL INFILE '../Raw_Data/MenuItem.csv'
INTO TABLE menuItem
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;


SELECT COUNT(*) FROM dish WHERE id IS NULL;

SELECT MIN(first_appeared), MAX(first_appeared), MIN(last_appeared), MAX(last_appeared) FROM dish;

SELECT COUNT(*) FROM dish WHERE first_appeared > last_appeared;

SELECT COUNT(*) FROM dish WHERE lowest_price IS NULL OR highest_price IS NULL;

SELECT COUNT(*) FROM dish WHERE lowest_price > highest_price;

SELECT COUNT(*) FROM menu WHERE id IS NULL;

SELECT COUNT(*) FROM menu WHERE sponsor IS NULL;

SELECT COUNT(*) FROM menupage WHERE id IS NULL;

SELECT COUNT(*) FROM menupage WHERE menu_id IS NULL;

SELECT COUNT(*) FROM menupage WHERE menu_id NOT IN (SELECT id FROM menu);

SELECT COUNT(*) FROM menuItem WHERE id IS NULL;

SELECT COUNT(*) FROM menuItem WHERE menu_page_id IS NULL;

SELECT COUNT(*) FROM menuItem WHERE dish_id IS NULL;

SELECT COUNT(*) FROM menuItem WHERE price IS NULL;

SELECT COUNT(*) FROM menuItem WHERE price=0;

SELECT COUNT(*) FROM menuItem WHERE high_price IS NULL;