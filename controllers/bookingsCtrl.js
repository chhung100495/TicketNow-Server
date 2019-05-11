var express = require('express');
var bookingsRepo = require('../repositories/bookingsRepo');

var router = express.Router();

router.get('/account/:id', (req, res) => {
    var id = req.params.id;
    bookingsRepo.loadByAccountID(id)
        .then(rows => {
            if (rows.length > 0) {
                var arr = [];
                var flag = 0;
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].id != flag) {
                        var seats = [];
                        for (var j = 0; j < rows.length; j++) {
                            if (rows[i].id == rows[j].id) {
                                seats.push({row: rows[j].row, number: rows[j].number });
                            }
                        }
                        var bookings = {    id: rows[i].id,
                                            movieName: rows[i].movieName,
                                            minAge: rows[i].minAge,
                                            type: rows[i].type,
                                            imgURL: rows[i].imgURL,
                                            cinemaName: rows[i].cinemaName,
                                            runningTime: rows[i].runningTime,
                                            iconURL: rows[i].iconURL,
                                            address: rows[i].address,
                                            room: rows[i].room,
                                            releaseDate: rows[i].releaseDate,
                                            time: rows[i].time,
                                            code: rows[i].code,
                                            bookedSeatList: seats };
                        arr.push(bookings);
                        flag = rows[i].id;
                    }
                }
                var results = { result: arr };
                res.json(results);
            } else {
                res.statusCode = 204;
                res.end('No data');
            }
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.post('/add', (req, res) => {
    bookingsRepo.add(req.body)
        .then(values => {
            console.log(values);
            if (values[0].affectedRows != 0) {
                res.statusCode = 201;
                res.json({
                    result: {id: values[0].insertId}
                });
            }
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.get('/:bookingID/account/:accountID', (req, res) => {
    var bookingID = req.params.bookingID;
    var accountID = req.params.accountID;
    bookingsRepo.loadSingle(bookingID, accountID)
        .then(rows => {
            if (rows.length > 0) {
                var seats = [];
                for (var i = 0; i < rows.length; i++) {
                    seats.push({row: rows[i].row, number: rows[i].number });
                }
                var obj = {
                    movieName: rows[0].movieName,
                    minAge: rows[0].minAge,
                    type: rows[0].type,
                    runningTime: rows[0].runningTime,
                    cinemaName: rows[0].cinemaName,
                    iconURL: rows[0].iconURL,
                    address: rows[0].address,
                    room: rows[0].room,
                    releaseDate: rows[0].releaseDate,
                    time: rows[0].time,
                    room: rows[0].room,
                    code: rows[0].code,
                    bookedSeats: seats
                }
                var results = { result: obj };
                res.json(results);
            } else {
                res.statusCode = 204;
                res.end('No data');
            }
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

module.exports = router;