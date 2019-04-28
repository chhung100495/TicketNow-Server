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

module.exports = router;