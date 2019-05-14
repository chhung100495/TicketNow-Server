var express = require('express');
var venuesRepo = require('../repositories/venuesRepo');

var router = express.Router();

router.get('/', (req, res) => {
    venuesRepo.loadAll()
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
});

module.exports = router;