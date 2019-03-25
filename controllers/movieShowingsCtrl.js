var express = require('express');
var movieShowingsRepo = require('../repositories/movieShowingsRepo');

var router = express.Router();

router.get('/', (req, res) => {
    movieShowingsRepo.loadAll()
        .then(rows => {
            res.json(rows);
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
})

router.get('/:id', (req, res) => {
    var id = req.params.id;
    movieShowingsRepo.loadSingle(id)
        .then(rows => {
            if (rows.length > 0) {
                res.json(rows[0]);
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