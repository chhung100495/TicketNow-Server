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
                                            type: rows[i].type,
                                            code: rows[i].code,

                                            movieName: rows[i].movieName,
                                            minAge: rows[i].minAge,
                                            runningTime: rows[i].runningTime,
                                            movieType: rows[i].movieType,
                                            genre: rows[i].genre,
                                            cinemaName: rows[i].cinemaName,
                                            movieIconURL: rows[i].movieIconURL,

                                            ...(rows[i].type == 0 ? {time: rows[i].movieTime} : {time: rows[i].eventTime}),
                                            ...(rows[i].type == 0 ? {room: rows[i].room} : {venue: rows[i].room}),
                                            address: (rows[i].type == 0 ? rows[i].cinemaAddress : rows[i].venueAddress),
                                            imgURL: (rows[i].type == 0 ? rows[i].movieImgURL : rows[i].eventImgURL),
                                            iconURL: (rows[i].type == 0 ? rows[i].cinemaIconURL : rows[i].unitIconURL),
                                            releaseDate: (rows[i].type == 0 ? rows[i].movieReleaseDate : rows[i].eventReleaseDate),

                                            eventName: rows[i].eventName,
                                            eventCategory: rows[i].eventCategory,
                                            unitName: rows[i].unitName,
                                            gateway: rows[i].gateway,
                                            organizer: rows[i].organizer,
                                            description: rows[i].description,
                                            block: rows[i].block,

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
                    id: rows[0].id,
                    type: rows[0].type,
                    code: rows[0].code,

                    movieName: rows[0].movieName,
                    minAge: rows[0].minAge,
                    runningTime: rows[0].runningTime,
                    cinemaName: rows[0].cinemaName,
                    genre: rows[0].genre,

                    ...(rows[0].type == 0 ? {time: rows[0].movieTime} : {time: rows[0].eventTime}),
                    ...(rows[0].type == 0 ? {room: rows[0].room} : {venue: rows[0].room}),
                    address: (rows[0].type == 0 ? rows[0].cinemaAddress : rows[0].venueAddress),
                    imgURL: (rows[0].type == 0 ? rows[0].movieImgURL : rows[0].eventImgURL),
                    iconURL: (rows[0].type == 0 ? rows[0].cinemaIconURL : rows[0].unitIconURL),
                    releaseDate: (rows[0].type == 0 ? rows[0].movieReleaseDate : rows[0].eventReleaseDate),

                    eventName: rows[0].eventName,
                    eventCategory: rows[0].eventCategory,
                    unitName: rows[0].unitName,
                    gateway: rows[0].gateway,
                    organizer: rows[0].organizer,
                    description: rows[0].description,
                    block: rows[0].block,

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