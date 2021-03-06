var express = require('express');
var cinemasRepo = require('../repositories/cinemasRepo');
var moment = require('moment');

var router = express.Router();

router.get('/:id/showing/:date', (req, res) => {
    var movieID = req.params.id;
    var date = new Date(parseInt(req.params.date));
    var formattedDate = moment(date).format("YYYY-MM-DD");
    cinemasRepo.loadByDay(movieID, formattedDate)
        .then(rows => {
            if (rows.length > 0) {
                var arr = [];
                var flag = 0;
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].movieID != flag) {
                        var showTimes = [];
                        for (var j = 0; j < rows.length; j++) {
                            if (rows[i].movieID == rows[j].movieID) {
                                showTimes.push({id: rows[j].movieShowingID, type: rows[j].type, price: rows[j].price, time: rows[j].time, location_id: rows[j].locationID, location_name: rows[j].locationName, totalSeats: rows[j].totalSeats });
                            }
                        }
                        var cinemas = { id: rows[i].movieID,
                                        name: rows[i].movieName,
                                        imgURL: rows[i].imgURL,
                                        trailerURL: rows[i].trailerURL,
                                        score: rows[i].score,
                                        minAge: rows[i].minAge,
                                        runningTime: rows[i].runningTime,
                                        genre: rows[i].genre,
                                        initialRelease: rows[i].initialRelease,
                                        description: rows[i].description,
                                        director: rows[i].director,
                                        cast: rows[i].cast,
                                        showTimes };
                        arr.push(cinemas);
                        flag = rows[i].movieID;
                    }
                }
                var results = {result: arr};
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

router.get('/:id', (req, res) => {
    var id = req.params.id;
    cinemasRepo.loadSingle(id)
        .then(rows => {
            if (rows.length > 0) {
                var results = {result: rows};
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