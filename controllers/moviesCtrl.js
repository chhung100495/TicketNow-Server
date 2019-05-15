var express = require('express');
var moviesRepo = require('../repositories/moviesRepo');
var moment = require('moment');

var router = express.Router();

router.get('/showing', (req, res) => {
    var pageNo = parseInt(req.query.pageNo);
    var size = parseInt(req.query.size);
    if (pageNo < 0 || pageNo === 0) {
        response = { "error": true,
                     "message": "invalid page number, should start with 1"};
        return res.json(response);
    }
    if (!pageNo) {
        // Set default of 1 for pageNo and 6 for size if a value isn't provided by the client
        pageNo = 1;
        size = 6;
    }
    var skip = size * (pageNo - 1);
    moviesRepo.loadShowing(size, skip)
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
    var pageNo = parseInt(req.query.pageNo);
    var size = parseInt(req.query.size);
    if (pageNo < 0 || pageNo === 0) {
        response = { "error": true,
                     "message": "invalid page number, should start with 1"};
        return res.json(response);
    }
    if (!pageNo) {
        // Set default of 1 for pageNo and 3 for size if a value isn't provided by the client
        pageNo = 1;
        size = 3;
    }
    var skip = size * (pageNo - 1);
    moviesRepo.loadMostFavorite(size, skip)
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
    var pageNo = parseInt(req.query.pageNo);
    var size = parseInt(req.query.size);
    if (pageNo < 0 || pageNo === 0) {
        response = { "error": true,
                     "message": "invalid page number, should start with 1"};
        return res.json(response);
    }
    if (!pageNo) {
        // Set default of 1 for pageNo and 6 for size if a value isn't provided by the client
        pageNo = 1;
        size = 6;
    }
    var skip = size * (pageNo - 1);
    console.log(size, skip)
    moviesRepo.loadCommingSoon(size, skip)
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

router.get('/:id/showing/:date', (req, res) => {
    var movieID = req.params.id;
    var date = new Date(parseInt(req.params.date));
    var formattedDate = moment(date).format("YYYY-MM-DD");
    moviesRepo.loadByDay(movieID, formattedDate)
        .then(rows => {
            if (rows.length > 0) {
                var arr = [];
                var flag = 0;
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].cinemaID != flag) {
                        var showTimes = [];
                        for (var j = 0; j < rows.length; j++) {
                            if (rows[i].cinemaID == rows[j].cinemaID) {
                                showTimes.push({id: rows[j].movieShowingID, type: rows[j].type, price: rows[j].price, time: rows[j].time, location_id: rows[j].locationID, location_name: rows[j].locationName, totalSeats: rows[j].totalSeats });
                            }
                        }
                        var cinemas = { cinemaID: rows[i].cinemaID,
                                        cinemaName: rows[i].cinemaName,
                                        iconURL: rows[i].iconURL,
                                        address: rows[i].address,
                                        showTimes };
                        arr.push(cinemas);
                        flag = rows[i].cinemaID;
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