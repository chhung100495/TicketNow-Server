var db = require('../fn/mysql-db');

exports.loadAll = function(id) {
    var sql = `SELECT n.id, n.img_url as imgURL, n.title, n.brief, n.content, n.type, n.created_at as createdAt FROM notifications as n`;
    return db.load(sql);
}