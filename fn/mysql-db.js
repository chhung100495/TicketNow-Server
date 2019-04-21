var mysql = require('mysql');

// var config = {
//     host     : 'localhost',
//     port     : '3306',
//     user     : 'root',
//     password : '',
//     database : 'booking_tickets'
// };

// mysql://b6a2871d0e51fc:cd5fd474@us-cdbr-iron-east-03.cleardb.net/heroku_9795ac331e55444?reconnect=true
var config = {
    host     : 'us-cdbr-iron-east-03.cleardb.net',
    port     : '3306',
    user     : 'b6a2871d0e51fc',
    password : 'cd5fd474',
    database : 'heroku_9795ac331e55444'
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

exports.write = function(sql) {
    return new Promise((resolve, reject) => {
        var connection = mysql.createConnection(config);

        connection.connect();

        connection.query(sql, (error, value) => {
            if (error)
                reject(error);
            else
                resolve(value);

            connection.end();
        });
    });
}

exports.executeTransaction = function(queries) {
    return new Promise((resolve, reject) => {
        var connection = mysql.createConnection(config);

        connection.connect();

        var results = [];

        /* Begin transaction */
        connection.beginTransaction(function(err) {
            if (err) { reject(err); }

            connection.query(queries[0], function(err, result) {
                if (err) {
                    connection.rollback(function() {
                        reject(err);
                    });
                }

                results = results.concat(result);

                var id = result.insertId;

                connection.query(queries[1], id, function(err, result) {
                    if (err) {
                        connection.rollback(function() {
                            reject(err);
                        });
                    }

                    results = results.concat(result);

                    connection.commit(function(err) {
                        if (err) {
                            connection.rollback(function() {
                                reject(err);
                            });
                        }
                        resolve(results);
                        console.log('Transaction Complete');
                        connection.end();
                    });
                });
            });
        });
        /* End transaction */
    });
}