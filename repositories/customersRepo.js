var db = require('../fn/mysql-db');

exports.add = (customerEntity) => {
    var sql = `INSERT INTO customers(full_name, gender, email, phone, address, credit_card_number, expiration_date)
        values('${customerEntity.full_name}', '${customerEntity.gender}', '${customerEntity.email}', '${customerEntity.phone}', '${customerEntity.address}', '${customerEntity.credit_card_number}', '${customerEntity.expiration_date}')`;
	return db.write(sql);
}

exports.update = (customerEntity) => {
    var sql = `UPDATE customers
        SET full_name = '${customerEntity.full_name}', gender = '${customerEntity.gender}', email = '${customerEntity.email}', phone = '${customerEntity.phone}', address = '${customerEntity.address}', credit_card_number = '${customerEntity.credit_card_number}', expiration_date = '${customerEntity.expiration_date}'
        WHERE id = '${customerEntity.id}'`
	return db.write(sql);
}

exports.loadSingle = (id) => {
    var sql = `SELECT acc.username, cus.full_name, cus.gender, cus.email, cus.phone, cus.address, cus.credit_card_number, cus.expiration_date FROM accounts as acc INNER JOIN customers as cus ON acc.customer_id = cus.id WHERE acc.id = ${id}`;
    return db.load(sql);
}