var db = require('../fn/mysql-db');
var genCode = require('../fn/generateCode').genCode;
var constants = require('../utilities/constants');

exports.loadSingle = function(bookingID, accountID) {
    var sql = `SELECT bk.id, bk.code, bk.type,
        s.row, s.number,
        l.name as room,

        m.name as movieName, m.min_age as minAge, m.running_time as runningTime, m.genre,
        c.name as cinemaName, c.icon_url as cinemaIconURL, c.address as cinemaAddress,
        ms.release_date as movieReleaseDate, ms.time as movieTime, ms.type as movieType,

        ev.name as eventName, ev.category as eventCategory, ev.img_url as eventImgURL, ev.release_date as eventReleaseDate, ev.time as eventTime, ev.organizer, ev.description,
        sl.gateway,
        u.name as unitName, u.icon_url as unitIconURL,
        v.address as venueAddress,
        b.name as block

        FROM bookings as bk
        INNER JOIN booked_seats as bs ON bs.booking_id = bk.id
        INNER JOIN seats as s ON s.id = bs.seat_id

        LEFT JOIN movie_showings as ms ON ms.id = bk.movie_showings_id
        LEFT JOIN movies as m ON m.id = ms.movie_id
        LEFT JOIN auditoriums as adt ON adt.id = ms.auditorium_id
        LEFT JOIN cinemas as c ON c.id = adt.cinema_id

        LEFT JOIN sales as sl ON sl.id = bk.sale_id
        LEFT JOIN events as ev ON ev.id = sl.event_id
        LEFT JOIN venues as v ON v.id = sl.venue_id
        LEFT JOIN units as u ON u.id = sl.unit_id
        LEFT JOIN blocks as b ON b.id = sl.block_id

        INNER JOIN locations as l ON l.id = adt.location_id OR v.location_id = l.id
        WHERE bk.id = '${bookingID}' AND bk.account_id = '${accountID}'`;
    return db.load(sql);
}

exports.loadByAccountID = function(id) {
    var sql = `SELECT DISTINCT m.name as movieName, m.min_age as minAge, m.img_url as movieImgURL, m.running_time as runningTime, m.genre,
        c.name as cinemaName, c.icon_url as cinemaIconURL, c.address as cinemaAddress,
        ms.type as movieType, ms.release_date as movieReleaseDate, ms.time as movieTime,

        bk.code, bk.id, bk.type,
        s.row, s.number,
        l.name as room,

        ev.name as eventName, ev.category as eventCategory, ev.img_url as eventImgURL, ev.release_date as eventReleaseDate, ev.time as eventTime, ev.organizer, ev.description,
        sl.gateway,
        u.name as unitName, u.icon_url as unitIconURL,
        v.address as venueAddress,
        b.name as block

        FROM bookings as bk
        INNER JOIN booked_seats as bs ON bs.booking_id = bk.id
        INNER JOIN seats as s ON s.id = bs.seat_id

        LEFT JOIN movie_showings as ms ON ms.id = bk.movie_showings_id
        LEFT JOIN movies as m ON m.id = ms.movie_id
        LEFT JOIN auditoriums as adt ON adt.id = ms.auditorium_id
        LEFT JOIN cinemas as c ON c.id = adt.cinema_id

        LEFT JOIN sales as sl ON sl.id = bk.sale_id
        LEFT JOIN events as ev ON ev.id = sl.event_id
        LEFT JOIN venues as v ON v.id = sl.venue_id
        LEFT JOIN units as u ON u.id = sl.unit_id
        LEFT JOIN blocks as b ON b.id = sl.block_id

        INNER JOIN locations as l ON l.id = adt.location_id OR v.location_id = l.id
        WHERE bk.account_id = '${id}'
        ORDER BY bk.id DESC`;
    return db.load(sql);
}

exports.add = function(bookingEntity) {
    var code = genCode(7);
    var insertBookingsRecord = ``;
    var updateNumberOfTickets = ``;
    switch (bookingEntity.type) {
        case constants.BookingType.MOVIE: {
            insertBookingsRecord = `INSERT INTO bookings(account_id, movie_showings_id, code, type)
                values('${bookingEntity.account_id}', '${bookingEntity.movie_showings_id}', '${code}', '${bookingEntity.type}')`;
            updateNumberOfTickets = `SELECT (1)`;
            break;
        }
        case constants.BookingType.SPORT: {
            insertBookingsRecord = `INSERT INTO bookings(account_id, sale_id, code, type)
                values('${bookingEntity.account_id}', '${bookingEntity.sale_id}', '${code}', '${bookingEntity.type}')`;
            updateNumberOfTickets = `UPDATE sales as s SET s.number_of_tickets = s.number_of_tickets - '${bookingEntity.bookedSeats.length}' WHERE s.id = '${bookingEntity.sale_id}'`;
            break;
        }
    }

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
    queries = [insertBookingsRecord, insertBookedSeatsRecord, insertBookedCombosRecord, updateNumberOfTickets];
    return db.executeBooking(queries, numOfBookedSeatsRecord, numOfBookedCombosRecord);
}