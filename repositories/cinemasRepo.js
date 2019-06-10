var db = require('../fn/mysql-db');

exports.loadAll = function() {
    var sql = ``;
    return db.load(sql);
}

exports.loadSingle = function(id) {
    var sql = `SELECT c.id, c.name, c.view_url as viewURL, c.address, c.phone, c.operating_hours as operatingHours, c.introduce, c.avg_point as avgPoint,
        cnp.icon_url
        FROM cinemas as c
        INNER JOIN cineplex as cnp ON cnp.id = c.cineplex_id
        WHERE c.id = '${id}'`;
    return db.load(sql);
}

exports.loadByDay = function(movieID, date) {
    var sql = `SELECT m.id as movieID, m.name as movieName, m.img_url as imgURL, m.score, m.min_age as minAge, m.running_time as runningTime, m.genre, m.initial_release as initialRelease,
        ms.id as movieShowingID, ms.price, ms.time, ms.type,
        l.id as locationID, l.name as locationName, l.total_seats as totalSeats
        FROM cinemas as c
        INNER JOIN auditoriums as a ON a.cinema_id = c.id
        INNER JOIN locations as l ON l.id = a.location_id
        INNER JOIN movie_showings as ms ON ms.auditorium_id = a.id
        INNER JOIN movies as m ON m.id = ms.movie_id
        WHERE c.id = '${movieID}' AND ms.release_date = '${date}'`;
    return db.load(sql);
}