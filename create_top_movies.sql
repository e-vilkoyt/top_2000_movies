-- Create the database
CREATE DATABASE top_movies;

-- Create the tables
USE top_movies;

CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    actor_name VARCHAR(255),
    actor_gender CHAR(1)
);

CREATE TABLE directors (
    director_id INT PRIMARY KEY,
    director_name VARCHAR(255),
    director_gender CHAR(1)
);

CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(255)
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255),
    rating FLOAT,
    meta_score FLOAT,
    year INT,
    revenue BIGINT,
    director_id INT,
    FOREIGN KEY (director_id) REFERENCES directors(director_id)
);

CREATE TABLE cast (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);

CREATE TABLE movies_genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);