USE top_movies;

-- Check the total number of movies
SELECT COUNT(*) AS total_movies
FROM movies;

-- Count how many actors and actresses are on the table
SELECT actor_gender, COUNT(*) AS total
FROM actors
GROUP BY actor_gender;

-- Count the number of men and women in the director's table
SELECT director_gender, COUNT(*) AS total
FROM directors
GROUP BY director_gender;

-- Calculate the overall average rating
SELECT ROUND(AVG(rating),2) AS avg_rating
FROM movies;

-- Calculate the average rating for female directors
SELECT ROUND(AVG(m.rating)) AS female_directors_avg
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'F';

-- Calculate the average rating for male directors
SELECT ROUND(AVG(m.rating)) AS male_directors_avg
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'M';

-- Calculate the overall average rating of critics
SELECT ROUND(AVG(meta_score),2) AS avg_meta_score
FROM movies;

-- Calculate the average critics score for male directors
SELECT ROUND(AVG(m.meta_score)) AS male_directors_score
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'M';

-- Calculate the average critics score for female directors
SELECT ROUND(AVG(m.meta_score)) AS female_directors_score
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'F';

-- Calculate the overall average revenue
SELECT ROUND(AVG(revenue), 2) AS avg_revenue
FROM movies WHERE revenue > 0;

-- Calculate the average revenue for movies with a female director
SELECT ROUND(AVG(m.revenue)) AS female_directors_revenue
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'F' AND m.revenue > 0;

-- Calculate the average revenue for movies with a male director
SELECT ROUND(AVG(m.revenue)) AS male_directors_revenue
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'M' AND m.revenue > 0;

-- Count the dataframe movies directed by women
SELECT COUNT(*) AS female_director_movies
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'F';

-- Count the dataframe movies directed by men
SELECT COUNT(*) AS male_director_movies
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'M';

-- Count how many times women appear in the cast of movies
SELECT COUNT(*) AS female_cast_representation
FROM cast AS c
JOIN actors AS a ON c.actor_id = a.actor_id
WHERE a.actor_gender = 'F';

-- Count how many times men appear in the cast of movies
SELECT COUNT(*) AS male_cast_representation
FROM cast AS c
JOIN actors AS a ON c.actor_id = a.actor_id
WHERE a.actor_gender = 'M';

-- Calculate the percentage of men and women in the movie's cast
SELECT 
    actor_gender, 
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cast), 2) AS percentage
FROM cast AS c
JOIN actors AS a ON c.actor_id = a.actor_id
GROUP BY actor_gender;

-- Number of movies for each genre
SELECT g.genre_name, COUNT(*) AS total_movies
FROM movies_genres AS mg
JOIN genres AS g ON mg.genre_id = g.genre_id
GROUP BY g.genre_name;

-- Percentage of female representation in each movie genre
SELECT g.genre_name,
       ROUND((SELECT COUNT(*)
              FROM actors AS a
              JOIN cast AS c ON a.actor_id = c.actor_id
              JOIN movies AS m ON c.movie_id = m.movie_id
              JOIN movies_genres AS mg ON m.movie_id = mg.movie_id
              WHERE a.actor_gender = 'F' AND mg.genre_id = g.genre_id) * 100.0 /
             (SELECT COUNT(*)
              FROM actors AS a
              JOIN cast AS c ON a.actor_id = c.actor_id
              JOIN movies AS m ON c.movie_id = m.movie_id
              JOIN movies_genres AS mg ON m.movie_id = mg.movie_id
              WHERE mg.genre_id = g.genre_id), 2) AS female_percentage
FROM genres AS g
ORDER BY female_percentage DESC;

-- Percentage of female direction in each movie genre
SELECT g.genre_name,
       ROUND((SELECT COUNT(*)
              FROM directors AS d
              JOIN movies AS m ON d.director_id = m.director_id
              JOIN movies_genres AS mg ON m.movie_id = mg.movie_id
              WHERE d.director_gender = 'F' AND mg.genre_id = g.genre_id) * 100.0 /
             (SELECT COUNT(*)
              FROM directors AS d
              JOIN movies AS m ON d.director_id = m.director_id
              JOIN movies_genres AS mg ON m.movie_id = mg.movie_id
              WHERE mg.genre_id = g.genre_id), 2) AS female_dir_percentage 
FROM genres AS g
ORDER BY female_dir_percentage DESC;

-- Temporal trend of actresses in movies
SELECT 
    m.year,
    ROUND(SUM(CASE WHEN a.actor_gender = 'F' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS female_cast_percentage
FROM cast AS c
JOIN actors AS a ON c.actor_id = a.actor_id
JOIN movies AS m ON c.movie_id = m.movie_id
GROUP BY m.year
ORDER BY m.year;

-- Temporal trend of female directors in movies:
SELECT 
    m.year,
    COUNT(*) AS total_movies_by_female_directors
FROM movies AS m
JOIN directors AS d ON m.director_id = d.director_id
WHERE d.director_gender = 'F'
GROUP BY m.year
ORDER BY m.year;