var db = require('../fn/mysql-db');

exports.loadAll = function() {
    var sql = `SELECT m.id, m.name, m.img_url as imgURL, m.trailer_url as trailerURL, m.score, m.description, m.min_age as minAge, m.director, m.cast, m.running_time as runningTime, m.genre, m.initial_release as initialRelease
        FROM movie as ms`;
    return db.load(sql);
}

exports.loadShowing = function() {
    var sql = `SELECT DISTINCT m.id, m.name, m.img_url as imgURL, m.trailer_url as trailerURL, m.score, m.description, m.min_age as minAge, m.director, m.cast, m.running_time as runningTime, m.genre, m.initial_release as initialRelease
        FROM movies as m
        INNER JOIN movie_showings as ms ON ms.movie_id = m.id`;
    return db.load(sql);
}

exports.loadMostFavorite = function() {
    var sql = `SELECT m.id, m.name, m.img_url as imgURL, m.trailer_url as trailerURL, m.score, m.description, m.min_age as minAge, m.director, m.cast, m.running_time as runningTime, m.genre, m.initial_release as initialRelease
        FROM movies as m
        ORDER BY m.score DESC
        LIMIT 3`;
    return db.load(sql);
}

exports.loadCommingSoon = function() {
    var sql = `SELECT m.id, m.name, m.img_url as imgURL, m.trailer_url as trailerURL, m.score, m.description, m.min_age as minAge, m.director, m.cast, m.running_time as runningTime, m.genre, m.initial_release as initialRelease
        FROM movies as m
        WHERE CURDATE() < m.initial_release`;
    return db.load(sql);
}

exports.loadSingle = function(id) {
    var sql = `SELECT ms. auditorium_id as auditoriumID, ms.price, ms.status,
        m.id, m.name, m.img_url as imgURL, m.trailer_url as trailerURL, m.score, m.description, m.min_age as minAge, m.director, m.cast, m.running_time as runningTime, m.genre, m.initial_release as initialRelease,
        c.name as cinemas
        FROM movie_showings as ms
        INNER JOIN movies as m ON ms.movie_id = m.id
        INNER JOIN auditoriums as a ON ms.auditorium_id = a.id
        INNER JOIN cinemas as c ON a.cinema_id = c.id
        WHERE ms.id = '${id}'`;
    return db.load(sql);
}

exports.loadByDay = function(movieID, date) {
    var sql = `SELECT m.name as movieName, c.name as cinemaName, c.id as cinemaID, c.address as address, l.name as location, l.total_seats as totalSeats, ms.price, ms.time
        FROM movies as m
        INNER JOIN movie_showings as ms ON ms.movie_id = m.id
        INNER JOIN auditoriums as a ON ms.auditorium_id = a.id
        INNER JOIN cinemas as c ON a.cinema_id = c.id
        INNER JOIN locations as l ON l.id = a.location_id
        WHERE ms.movie_id = '${movieID}' AND ms.release_date = '${date}'
        ORDER BY c.id ASC, ms.time ASC`;
    return db.load(sql);
}