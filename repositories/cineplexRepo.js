var db = require('../fn/mysql-db');

exports.loadAll = function() {
    var sql = `SELECT cnp.id as cineplexID, cnp.icon_url as iconURL, cnp.name as cineplexName,
        c.id as cinemaID, c.name as cinemaName, c.address, c.avg_point as avgPoint,
        (SELECT COUNT(c.id) FROM cinemas as c WHERE c.cineplex_id = cnp.id) as numberOfCinemas
        FROM cineplex as cnp
        INNER JOIN cinemas as c ON c.cineplex_id = cnp.id
        ORDER BY cnp.id ASC`;
    return db.load(sql);
}
