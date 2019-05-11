var mysql = require('mysql');

// var config = {
//     host     : 'localhost',
//     port     : '3306',
//     user     : 'root',
//     password : '',
//     database : 'booking_tickets',
//     multipleStatements: true
// };

// mysql://b6a2871d0e51fc:cd5fd474@us-cdbr-iron-east-03.cleardb.net/heroku_9795ac331e55444?reconnect=true
var config = {
    host     : 'us-cdbr-iron-east-03.cleardb.net',
    port     : '3306',
    user     : 'b6a2871d0e51fc',
    password : 'cd5fd474',
    database : 'heroku_9795ac331e55444',
    multipleStatements: true
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

exports.executeBooking = function(queries, numOfBookedSeatsRecord, numOfBookedCombosRecord) {
    return new Promise((resolve, reject) => {
        var connection = mysql.createConnection(config);

        connection.connect();

        var bookingResults = [];

        /* Begin transaction */
        connection.beginTransaction(function(err) {
            if (err) { reject(err); }

            connection.query(queries[0], function(err, result) {
                if (err) {
                    connection.rollback(function() {
                        reject(err);
                    });
                }

                bookingResults = bookingResults.concat(result);

                var id = result.insertId;

                var arrayID = [];
                for (var i = 0; i < numOfBookedSeatsRecord; i++) {
                    arrayID.push(id);
                }
                connection.query(queries[1], arrayID, function(err, results, fields) {
                    if (err) {
                        connection.rollback(function() {
                            reject(err);
                        });
                    }

                    for (var i = 0; i < results.length; i++) {
                        bookingResults = bookingResults.concat(results[i]);
                    }

                    if (numOfBookedCombosRecord > 0) {
                        arrayID = [];
                        for (var i = 0; i < numOfBookedCombosRecord; i++) {
                            arrayID.push(id);
                        }
                        connection.query(queries[2], arrayID, function(err, result, fields) {
                            if (err) {
                                connection.rollback(function() {
                                    reject(err);
                                });
                            }

                            for (var i = 0; i < results.length; i++) {
                                bookingResults = bookingResults.concat(results[i]);
                            }

                            connection.commit(function(err) {
                                if (err) {
                                    connection.rollback(function() {
                                        reject(err);
                                    });
                                }
                                resolve(bookingResults);
                                console.log('Transaction Complete');
                                connection.end();
                            });
                        });
                    } else {
                        connection.commit(function(err) {
                            if (err) {
                                connection.rollback(function() {
                                    reject(err);
                                });
                            }
                            resolve(bookingResults);
                            console.log('Transaction Complete');
                            connection.end();
                        });
                    }
                });
            });
        });
        /* End transaction */
    });
}