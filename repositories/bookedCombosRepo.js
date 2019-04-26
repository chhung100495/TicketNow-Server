var db = require('../fn/mysql-db');

exports.loadByBookingID = function(id) {
    var sql = `SELECT cb.name as combo,
        bc.booking_id, bc.quantity
        FROM booked_combos as bc
        INNER JOIN combos as cb ON cb.id = bc.combo_id
        WHERE bc.booking_id = '${id}'`;
    return db.load(sql);
}