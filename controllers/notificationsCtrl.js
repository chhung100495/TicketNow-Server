var express = require('express');
var notificationsRepo = require('../repositories/notificationsRepo');

var router = express.Router();

router.get('/', (req, res) => {
    notificationsRepo.loadAll()
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