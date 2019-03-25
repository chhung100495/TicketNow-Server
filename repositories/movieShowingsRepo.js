var db = require('../fn/mysql-db');

exports.loadAll = function() {
    var sql = `SELECT ms.*, m.*, c.name FROM movie_showings as ms
        INNER JOIN movies as m ON ms.movie_id = m.id
        INNER JOIN auditoriums as a ON ms.auditorium_id = a.id
        INNER JOIN cinemas as c ON a.cinema_id = c.id`;
    return db.load(sql);
}

exports.loadSingle = function(id) {
    var sql = `SELECT ms.*, m.*, c.name FROM movie_showings as ms
        INNER JOIN movies as m ON ms.movie_id = m.id
        INNER JOIN auditoriums as a ON ms.auditorium_id = a.id
        INNER JOIN cinemas as c ON a.cinema_id = c.id
        WHERE ms.id = '${id}'`;
    return db.load(sql);
}