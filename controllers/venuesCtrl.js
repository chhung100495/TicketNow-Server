var express = require('express');
var venuesRepo = require('../repositories/venuesRepo');
var moment = require("moment");

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

router.get('/:id', (req, res) => {
    var id = req.params.id;
    venuesRepo.loadSingle(id)
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

router.get('/:id/sale/:datetime', (req, res) => {
    var venueID = req.params.id;
    var datetime = new Date(parseInt(req.params.datetime));
    var formattedDateTime = moment(datetime).format("YYYY-MM-DD HH:mm:ss");
    venuesRepo.loadByDatetime(venueID, formattedDateTime)
        .then(rows => {
            if (rows.length > 0) {
                var arr = [];
                var flag = 0;
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].unitID != flag) {
                        var stands = [];
                        for (var j = 0; j < rows.length; j++) {
                            if (rows[i].unitID == rows[j].unitID) {
                                stands.push({saleID: rows[j].saleID, price: rows[j].price, time: rows[j].time, numberOfTickets: rows[j].numberOfTickets, blockName: rows[j].blockName });
                            }
                        }
                        var units = {   unitID: rows[i].unitID,
                                        unitName: rows[i].unitName,
                                        iconURL: rows[i].iconURL,
                                        stands };
                        arr.push(units);
                        flag = rows[i].unitID;
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

module.exports = router;