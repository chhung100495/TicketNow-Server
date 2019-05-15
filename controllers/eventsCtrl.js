var express = require('express');
var eventsRepo = require('../repositories/eventsRepo');
var moment = require('moment');

var router = express.Router();

router.get('/hotEvent', (req, res) => {
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
    eventsRepo.loadHotEvent(size, skip)
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
    eventsRepo.loadCommingSoon(size, skip)
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

router.get('/:id/sale/:datetime', (req, res) => {
    var eventID = req.params.id;
    var datetime = new Date(parseInt(req.params.datetime));
    var formattedDateTime = moment(datetime).format("YYYY-MM-DD HH:mm:ss");
    console.log(formattedDateTime);
    eventsRepo.loadByDay(eventID, formattedDateTime)
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

router.get('/:id', (req, res) => {
    var id = req.params.id;
    eventsRepo.loadSingle(id)
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