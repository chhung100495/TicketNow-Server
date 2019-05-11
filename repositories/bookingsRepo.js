var db = require('../fn/mysql-db');
var genCode = require('../fn/generateCode').genCode;

exports.loadSingle = function(bookingID, accountID) {
    var sql = `SELECT bk.code,
        m.name as movieName, m.min_age as minAge, m.running_time as runningTime, m.genre,
        c.name as cinemaName, c.icon_url as iconURL, c.address,
        ms.release_date as releaseDate, ms.time, ms.type,
        s.row, s.number,
        l.name as room
        FROM bookings as bk
        INNER JOIN movie_showings as ms ON ms.id = bk.movie_showings_id
        INNER JOIN movies as m ON m.id = ms.movie_id
        INNER JOIN booked_seats as bs ON bs.booking_id = bk.id
        INNER JOIN seats as s ON s.id = bs.seat_id
        INNER JOIN auditoriums as adt ON adt.id = ms.auditorium_id
        INNER JOIN cinemas as c ON c.id = adt.cinema_id
        INNER JOIN locations as l ON l.id = adt.location_id
        WHERE bk.id = '${bookingID}' AND bk.account_id = '${accountID}'`;
    return db.load(sql);
}

exports.loadByAccountID = function(id) {
    var sql = `SELECT DISTINCT m.name as movieName, m.min_age as minAge, m.img_url as imgURL, m.running_time as runningTime,
        c.name as cinemaName, c.icon_url as iconURL, c.address,
        l.name as room,
        ms.type, ms.release_date as releaseDate, ms.time,
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

exports.add = function(bookingEntity) {
    var code = genCode(7);
    var insertBookingsRecord = `INSERT INTO bookings(account_id, movie_showings_id, code)
        values('${bookingEntity.account_id}', '${bookingEntity.movie_showings_id}', '${code}')`;

    var insertBookedSeatsRecord = ``;
    var numOfBookedSeatsRecord = bookingEntity.bookedSeats.length;
    for (var i = 0; i < numOfBookedSeatsRecord; i++) {
        insertBookedSeatsRecord += `INSERT INTO booked_seats(booking_id, seat_id, price)
            values(?, '${bookingEntity.bookedSeats[i].seat_id}', '${bookingEntity.bookedSeats[i].price}'); `;
    }

    var insertBookedCombosRecord = ``;
    var numOfBookedCombosRecord = bookingEntity.bookedCombos.length;
    if (numOfBookedCombosRecord > 0) {
        for (var i = 0; i < numOfBookedCombosRecord; i++) {
            insertBookedCombosRecord += `INSERT INTO booked_combos(booking_id, combo_id, price, quantity)
                values(?, '${bookingEntity.bookedCombos[i].combo_id}', '${bookingEntity.bookedCombos[i].price}', '${bookingEntity.bookedCombos[i].quantity}'); `;
        }
    }
    queries = [insertBookingsRecord, insertBookedSeatsRecord, insertBookedCombosRecord]
    return db.executeBooking(queries, numOfBookedSeatsRecord, numOfBookedCombosRecord);
}