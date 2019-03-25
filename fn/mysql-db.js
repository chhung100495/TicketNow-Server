var mysql = require('mysql');

var config = {
    host     : 'localhost',
    port     : '3306',
    user     : 'root',
    password : '',
    database : 'booking_tickets'
};

exports.load = function(sql) {
    return new Promise((resolve, reject) => {
        var connection = mysql.createConnection(config);

        connection.connect();

        connection.query(sql, function(error, results, fields) {
            if (error)
                reject(error);
            else
                resolve(results);

            connection.end();
        });
    });
}