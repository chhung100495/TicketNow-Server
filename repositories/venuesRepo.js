var db = require('../fn/mysql-db');

exports.loadAll = function() {
    var sql = `SELECT v.id, v.name, v.view_url as viewURL, v.address, v.introduce, v.avg_point as avgPoint,
        l.total_seats as totalSeats
        FROM venues as v
        INNER JOIN locations as l ON l.id = v.location_id`;
    return db.load(sql);
}

exports.loadSingle = function(id) {
    var sql = `SELECT v.id, v.name, v.view_url, v.address, v.introduce, v.avg_point as avgPoint,
        l.total_seats as totalSeats
        FROM venues as v
        INNER JOIN locations as l ON l.id = v.location_id
        WHERE v.id = '${id}'`;
    return db.load(sql);
}

exports.loadByDatetime = function(venueID, datetime) {
    var sql = `SELECT sl.id as saleID, sl.price, sl.number_of_tickets as numberOfTickets,
        ev.id as eventID, ev.time, ev.name as eventName, ev.release_date as releaseDate, ev.organizer, ev.description, ev.img_url, ev.video_url,
        b.name as blockName,
        u.id as unitID, u.name as unitName, u.icon_url as iconURL
        FROM venues as v
        INNER JOIN sales as sl ON sl.venue_id = v.id
        INNER JOIN events as ev ON ev.id = sl.event_id
        INNER JOIN blocks as b ON b.id = sl.block_id
        INNER JOIN units as u ON u.id = sl.unit_id
        WHERE v.id = '${venueID}' AND sl.number_of_tickets > 0 AND (DATE(sl.start_date_sale) <= '${datetime}' AND DATE(sl.end_date_sale) >= '${datetime}')`;
    return db.load(sql);
}