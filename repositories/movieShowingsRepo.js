var db = require('../fn/mysql-db');

exports.loadAll = function() {
    var sql = `SELECT ms. auditorium_id as auditoriumID, ms.price, ms.status, ms.release_date as releaseDate,
        m.id, m.name, m.img_url as imgURL, m.score, m.description, m.min_age as minAge, m.director, m.cast, m.running_time as runningTime, m.genre,
        c.name as cinemas
        FROM movie_showings as ms
        INNER JOIN movies as m ON ms.movie_id = m.id
        INNER JOIN auditoriums as a ON ms.auditorium_id = a.id
        INNER JOIN cinemas as c ON a.cinema_id = c.id`;
    return db.load(sql);
}

exports.loadSingle = function(id) {
    var sql = `SELECT ms. auditorium_id as auditoriumID, ms.price, ms.status, ms.release_date as releaseDate,
        m.id, m.name, m.img_url as imgURL, m.score, m.description, m.min_age as minAge, m.director, m.cast, m.running_time as runningTime, m.genre,
        c.name as cinemas
        FROM movie_showings as ms
        INNER JOIN movies as m ON ms.movie_id = m.id
        INNER JOIN auditoriums as a ON ms.auditorium_id = a.id
        INNER JOIN cinemas as c ON a.cinema_id = c.id
        WHERE ms.id = '${id}'`;
    return db.load(sql);
}