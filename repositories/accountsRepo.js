var db = require('../fn/mysql-db');
var md5 = require('crypto-js/md5');

exports.checkUsernameAvailability = (accountEntity) => {
    var sql = `SELECT * FROM accounts WHERE username = '${accountEntity.username}'`;
    return db.load(sql);
}

exports.validateCredentials = (accountEntity) => {
    var md5_pwd = md5(accountEntity.password);
    var sql = `SELECT * FROM accounts WHERE username = '${accountEntity.username}' AND password = '${md5_pwd}'`;
    return db.load(sql);
}

exports.add = (accountEntity) => {
    var md5_pwd = md5(accountEntity.password);
    var sql = `INSERT INTO accounts(username, password, full_name, email, phone, credit_card_number, expiration_date)
        values('${accountEntity.username}', '${md5_pwd}', '${accountEntity.full_name}', '${accountEntity.email}', '${accountEntity.phone}', '${accountEntity.credit_card_number}', '${accountEntity.expiration_date}')`;
	return db.write(sql);
}

exports.loadSingle = (id) => {
    var sql = `SELECT username, full_name, email, phone FROM accounts WHERE id = ${id}`;
    return db.load(sql);
}