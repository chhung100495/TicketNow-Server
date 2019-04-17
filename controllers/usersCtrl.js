var express = require('express');
var usersRepo = require('../repositories/usersRepo');

var router = express.Router();

router.post('/add', (req, res) => {
    usersRepo.add(req.body)
        .then(value => {
            if (value.affectedRows == 1) {
                console.log(value);
                res.json({
                    msg: "Thêm thông tin người dùng thành công"
                })
            } else {
                res.statusCode = 400;
                res.end('Thêm thông tin người dùng thất bại');
            }

        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
});

router.post('/update', (req, res) => {
    usersRepo.update(req.body)
        .then(value => {
            if (value.affectedRows == 1) {
                res.json({
                    msg: "Cập nhật thông tin người dùng thành công"
                })
            } else {
                res.statusCode = 400;
                res.end('Cập nhật thông tin người dùng thất bại');
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
    usersRepo.loadSingle(id)
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