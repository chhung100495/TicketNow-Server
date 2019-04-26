var express = require('express');
var bookedSeatsRepo = require('../repositories/bookedSeatsRepo');

var router = express.Router();

router.get('/account/:id', (req, res) => {
    var id = req.params.id;
    bookedSeatsRepo.loadByBookingID(id)
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