var db = require('../fn/mysql-db');

exports.loadByAccountID = function(id) {
    var sql = `SELECT DISTINCT m.name as movieName, m.min_age as minAge, m.img_url as imgURL,
        c.name as cinemaName, c.icon_url as iconURL, c.address,
        l.name as room,
        ms.release_date as releaseDate, ms.time,
        bk.code, bk.id,
        s.row, s.number
        FROM bookings as bk
        INNER JOIN booked_seats as bs ON bs.booking_id = bk.id
        INNER JOIN seats as s ON s.id = bs.seat_id
        INNER JOIN movie_showings as ms ON ms.id = bk.movie_showings_id
        INNER JOIN movies as m ON m.id = ms.movie_id
        INNER JOIN auditoriums as adt ON adt.id = ms.auditorium_id
        INNER JOIN cinemas as c ON c.id = adt.cinema_id
        INNER JOIN locations as l ON l.id = adt.location_id
        WHERE bk.account_id = '${id}'
        ORDER BY bk.id ASC`;
    return db.load(sql);
}