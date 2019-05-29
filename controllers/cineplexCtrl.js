var express = require('express');
var cineplexRepo = require('../repositories/cineplexRepo');

var router = express.Router();

router.get('/', (req, res) => {
    cineplexRepo.loadAll()
        .then(rows => {
            if (rows.length > 0) {
                var arr = [];
                var flag = 0;
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].cineplexID != flag) {
                        var cinemas = [];
                        for (var j = 0; j < rows.length; j++) {
                            if (rows[i].cineplexID == rows[j].cineplexID) {
                                cinemas.push({ id: rows[j].cinemaID,
                                               cinemaName: rows[j].cinemaName,
                                               viewURL: rows[j].viewURL,
                                               phone: rows[j].phone,
                                               address: rows[j].address,
                                               operatingHours: rows[j].operatingHours,
                                               introduce: rows[j].introduce,
                                               avgPoint: rows[j].avgPoint });
                            }
                        }
                        var cineplex = { iconURL: rows[i].iconURL,
                                         name: rows[i].cineplexName,
                                         cinemas }
                        arr.push(cineplex);
                        flag = rows[i].cineplexID;
                    }
                }
                var results = {result: arr};
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