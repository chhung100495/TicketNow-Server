var db = require('../fn/mysql-db');

exports.loadAll = function() {
    var sql = `SELECT v.id, v.name, v.address, v.avg_point FROM venues as v`;
    return db.load(sql);
}
