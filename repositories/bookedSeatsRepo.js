var db = require('../fn/mysql-db');

exports.loadByBookingID = function(id) {
    var sql = `SELECT bs.booking_id as bookingID,
        b.name as block,
        s.row, s.number
        FROM booked_seats as bs
        INNER JOIN seats as s ON s.id = bs.seat_id
        INNER JOIN blocks as b ON b.id = s.block_id
        WHERE bs.booking_id = '${id}'`;
    return db.load(sql);
}