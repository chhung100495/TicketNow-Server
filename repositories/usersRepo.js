var db = require('../fn/mysql-db');

exports.add = (userEntity) => {
    var sql = `INSERT INTO users(full_name, gender, birthday, email, phone, address, credit_card_number, expiration_date)
        values('${userEntity.full_name}', '${userEntity.gender}', '${userEntity.birthday}', '${userEntity.email}', '${userEntity.phone}', '${userEntity.address}', '${userEntity.credit_card_number}', '${userEntity.expiration_date}')`;
	return db.write(sql);
}

exports.update = (userEntity) => {
    var sql = `UPDATE users
        SET full_name = '${userEntity.full_name}', gender = '${userEntity.gender}', birthday = '${userEntity.birthday}',email = '${userEntity.email}', phone = '${userEntity.phone}', address = '${userEntity.address}', credit_card_number = '${userEntity.credit_card_number}', expiration_date = '${userEntity.expiration_date}'
        WHERE id = '${userEntity.id}'`
	return db.write(sql);
}

exports.loadSingle = (id) => {
    var sql = `SELECT acc.username, usr.full_name, usr.gender,  usr.birthday, usr.email, usr.phone, usr.address, usr.credit_card_number, usr.expiration_date FROM accounts as acc INNER JOIN users as usr ON acc.user_id = usr.id WHERE acc.id = ${id}`;
    return db.load(sql);
}