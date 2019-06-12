var db = require('../fn/mysql-db');

exports.loadByShowTime = (movieShowingsID, locationID) => {
    var sql = `SELECT s.id, s.row, s.number, s.type, s.block_id as blockID, IF(bk.id IS NULL, 1, 0) as status
        FROM seats as s
        LEFT JOIN booked_seats as bs ON bs.seat_id = s.id
        LEFT JOIN bookings as bk ON bk.id = bs.booking_id AND bk.movie_showings_id = '${movieShowingsID}'
        WHERE s.location_id = '${locationID}'`;
    return db.load(sql);
}

exports.loadBySale = (saleID, locationID) => {
    var sql = `SELECT s.id, s.row, s.number, s.type, s.block_id as blockID, IF(bk.id IS NULL, 1, 0) as status
        FROM seats as s
        LEFT JOIN booked_seats as bs ON bs.seat_id = s.id
        LEFT JOIN bookings as bk ON bk.id = bs.booking_id AND bk.sale_id = '${saleID}'
        WHERE s.location_id = '${locationID}'`;
    return db.load(sql);
}