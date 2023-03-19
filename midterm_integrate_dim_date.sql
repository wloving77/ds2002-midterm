# ===================================================================================
# How to Integrate a Dimension table. In other words, how to look-up Foreign Key
# values FROM a dimension table and add them to new Fact table columns.
#
# First, go to Edit -> Preferences -> SQL Editor and disable 'Safe Edits'.
# Close SQL Workbench and Reconnect to the Server Instance.
# ===================================================================================

select * from fact_films;

USE `ds2002-midterm`;

# ==============================================================
# Step 1: Add New Column(s)
# ==============================================================
ALTER TABLE `ds2002-midterm`.fact_films
ADD COLUMN film_date_key int NOT NULL AFTER last_update,
ADD COLUMN film_actor_date_key int NOT NULL AFTER last_update_film_actor,
ADD COLUMN actor_date_key int NOT NULL AFTER last_update_actor,
ADD COLUMN category_date_key int NOT NULL AFTER last_update_category,
ADD COLUMN film_category_date_key int NOT NULL AFTER last_update_film_category,
ADD COLUMN language_date_key int NOT NULL AFTER last_update_language;

# ==============================================================
# Step 2: Update New Column(s) with value from Dimension table
#         WHERE Business Keys in both tables match.
# ==============================================================
UPDATE `ds2002-midterm`.fact_films as ff
JOIN `ds2002-midterm`.dim_date AS dd
ON DATE(ff.last_update) = dd.full_date
SET ff.film_date_key = dd.date_key;

UPDATE `ds2002-midterm`.fact_films as ff
JOIN `ds2002-midterm`.dim_date AS dd
ON DATE(ff.last_update_film_actor) = dd.full_date
SET ff.film_actor_date_key = dd.date_key;

UPDATE `ds2002-midterm`.fact_films as ff
JOIN `ds2002-midterm`.dim_date AS dd
ON DATE(ff.last_update_actor) = dd.full_date
SET ff.actor_date_key = dd.date_key;

UPDATE `ds2002-midterm`.fact_films as ff
JOIN `ds2002-midterm`.dim_date AS dd
ON DATE(ff.last_update_film_category) = dd.full_date
SET ff.film_category_date_key = dd.date_key;

UPDATE `ds2002-midterm`.fact_films as ff
JOIN `ds2002-midterm`.dim_date AS dd
ON DATE(ff.last_update_category) = dd.full_date
SET ff.category_date_key = dd.date_key;

UPDATE `ds2002-midterm`.fact_films as ff
JOIN `ds2002-midterm`.dim_date AS dd
ON DATE(ff.last_update_language) = dd.full_date
SET ff.language_date_key = dd.date_key;


# ==============================================================
# Step 3: Validate that newly updated columns contain valid data
# ==============================================================
SELECT last_update
	, film_date_key
    , last_update_film_actor
	, film_actor_date_key
    , last_update_actor
    , actor_date_key
    , last_update_film_category
    , film_category_date_key
    , last_update_category
    , category_date_key
    , last_update_language
	, language_date_key
FROM `ds2002-midterm`.fact_films
LIMIT 10;

# =============================================================
# Step 4: If values are correct then drop old column(s)
# =============================================================
ALTER TABLE `ds2002-midterm`.fact_films
DROP COLUMN last_update,
DROP COLUMN last_update_film_actor,
DROP COLUMN last_update_actor,
DROP COLUMN last_update_film_category,
DROP COLUMN last_update_category,
DROP COLUMN last_update_language;

# =============================================================
# Step 5: Validate Finished Fact Table.
# =============================================================
SELECT * FROM `ds2002-midterm`.fact_films
LIMIT 10;

