CREATE DATABASE trails_app;

CREATE TABLE trails (
    id SERIAL PRIMARY KEY,
    title TEXT,
    image_url TEXT,
    description TEXT, 
    difficulty TEXT,
    rating INT
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nickname TEXT,
    email TEXT,
    password_digest TEXT
);