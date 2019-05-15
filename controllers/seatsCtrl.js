var express = require('express');
var seatsRepo = require('../repositories/seatsRepo');

var router = express.Router();

router.get('/movieShowing/:movieShowingID/location/:locationID', (req, res) => {
    var movieShowingID = req.params.movieShowingID;
    var locationID = req.params.locationID;
    seatsRepo.loadByShowTime(movieShowingID, locationID)
        .then(rows => {
            if (rows.length > 0) {
                var results = {result: rows};
                res.json(results);
            } else {
                res.statusCode = 204;
                res.end('Không có dữ liệu');
            }
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.get('/sale/:saleID/location/:locationID', (req, res) => {
    var saleID = req.params.saleID;
    var locationID = req.params.locationID;
    seatsRepo.loadBySale(saleID, locationID)
        .then(rows => {
            if (rows.length > 0) {
                var results = {result: rows};
                res.json(results);
            } else {
                res.statusCode = 204;
                res.end('Không có dữ liệu');
            }
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

module.exports = router;