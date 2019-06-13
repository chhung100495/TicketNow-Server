var db = require('../fn/mysql-db');

exports.loadAll = function() {
    var sql = ``;
    return db.load(sql);
}

exports.loadHotEvent = function(size, skip) {
    var sql = `SELECT ev.id, ev.name, ev.img_url, ev.video_url, ev.release_date as releaseDate, ev.time, ev.organizer, ev.category, ev.description,
        sl.number_of_tickets
        FROM events as ev
        INNER JOIN sales as sl ON sl.event_id = ev.id
        GROUP BY ev.id
        ORDER BY sl.number_of_tickets ASC
        LIMIT ${size} OFFSET ${skip}`;
    return db.load(sql);
}

exports.loadCommingSoon = function(size, skip) {
    var sql = `SELECT ev.id, ev.name, ev.img_url, ev.video_url, ev.release_date as releaseDate, ev.time, ev.organizer, ev.category, ev.description
        FROM events as ev
        WHERE CURDATE() < ev.release_date
        LIMIT ${size} OFFSET ${skip}`;
    return db.load(sql);
}

exports.loadSingle = function(id) {
    var sql = `SELECT DISTINCT ev.id, ev.name as eventName, ev.img_url as imgURL, ev.video_url as videoURL, ev.release_date as releaseDate, ev.time, ev.organizer, ev.category, ev.description,
        v.name as venueName
        FROM events as ev
        INNER JOIN sales as sl ON sl.event_id = ev.id
        INNER JOIN venues as v ON v.id = sl.venue_id
        WHERE ev.id = '${id}'`;
    return db.load(sql);
}

exports.loadByDatetime = function(eventID, datetime) {
    var sql = `SELECT sl.id as saleID, sl.price, sl.number_of_tickets as numberOfTickets,
        ev.time,
        b.name as blockName,
        u.id as unitID, u.name as unitName, u.icon_url as iconURL
        FROM sales as sl
        INNER JOIN events as ev ON ev.id = sl.event_id
        INNER JOIN blocks as b ON b.id = sl.block_id
        INNER JOIN units as u ON u.id = sl.unit_id
        WHERE sl.event_id = '${eventID}' AND sl.number_of_tickets > 0 AND (sl.start_date_sale <= '${datetime}' AND sl.end_date_sale >= '${datetime}')`;
    return db.load(sql);
}