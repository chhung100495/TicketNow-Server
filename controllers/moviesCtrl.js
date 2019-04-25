var express = require('express');
var moviesRepo = require('../repositories/moviesRepo');
var moment = require('moment');

var router = express.Router();

router.get('/', (req, res) => {
    moviesRepo.loadAll()
        .then(rows => {
            var results = {result: rows};
            res.json(results);
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.get('/showing', (req, res) => {
    moviesRepo.loadShowing()
        .then(rows => {
            var results = {result: rows};
            res.json(results);
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.get('/mostFavorite', (req, res) => {
    moviesRepo.loadMostFavorite()
        .then(rows => {
            var results = {result: rows};
            res.json(results);
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.get('/commingSoon', (req, res) => {
    moviesRepo.loadCommingSoon()
        .then(rows => {
            var results = {result: rows};
            res.json(results);
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.post('/showing/byDay', (req, res) => {
    var movieID = req.body.movie_id;
    var date = new Date(req.body.date);
    var formattedDate = moment(date).format("YYYY-MM-DD");
    moviesRepo.loadByDay(movieID, formattedDate)
        .then(rows => {
            movie = rows[0].movieName;
            var arr = [];
            var flag = 0;
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].cinemaID != flag) {
                    var showTime = [];
                    for (var j = 0; j < rows.length; j++) {
                        if (rows[i].cinemaID == rows[j].cinemaID) {
                            showTime.push({price: rows[j].price, time: rows[j].time, location: rows[j].location, totalSeats: rows[j].totalSeats });
                        }
                    }
                    var cinemas = { cinemaName: rows[i].cinemaName,
                                    address: rows[i].address,
                                    showTime };
                    arr.push(cinemas);
                    flag = rows[i].cinemaID;
                }
            }
            var obj = { movie, cinemas: arr };
            var results = {result: obj};
            res.json(results);
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.get('/:id', (req, res) => {
    var id = req.params.id;
    moviesRepo.loadSingle(id)
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