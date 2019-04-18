var db = require('../fn/mysql-db');
var md5 = require('crypto-js/md5');

exports.checkUsernameAvailability = (accountEntity) => {
    var sql = `SELECT * FROM accounts WHERE username = '${accountEntity.username}'`;
    return db.load(sql);
}

exports.validateCredentials = (accountEntity) => {
    var md5_pwd = md5(accountEntity.password);
    var sql = `SELECT id, username, user_id FROM accounts WHERE username = '${accountEntity.username}' AND password = '${md5_pwd}'`;
    return db.load(sql);
}

exports.add = (accountEntity) => {
    var md5_pwd = md5(accountEntity.password);
    var sql1 = `INSERT INTO users(full_name, email, phone)
        values('${accountEntity.full_name}', '${accountEntity.email}', '${accountEntity.phone}')`;
    var sql2 = `INSERT INTO accounts(username, password, user_id) values('${accountEntity.username}', '${md5_pwd}', ?)`;
    queries = [sql1, sql2]
	return db.executeTransaction(queries);
}

exports.loadSingle = (id) => {
    var sql = `SELECT acc.username, usr.full_name, usr.gender, usr.birthday, usr.email, usr.phone, usr.address, usr.credit_card_number, usr.expiration_date FROM accounts as acc INNER JOIN users as usr ON acc.user_id = usr.id WHERE acc.id = ${id}`;
    return db.load(sql);
}

exports.changePassword = (accountEntity) => {
    var md5_cpwd = md5(accountEntity.current_password);
    var md5_npwd = md5(accountEntity.new_password);
    var sql = `UPDATE accounts
        SET password = '${md5_npwd}'
        WHERE id = '${accountEntity.id}' AND password = '${md5_cpwd}'`
    return db.load(sql);
}