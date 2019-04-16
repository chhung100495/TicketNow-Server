var express = require('express');
var accountsRepo = require('../repositories/accountsRepo');

var router = express.Router();

router.post('/register', (req, res) => {
    accountsRepo.checkUsernameAvailability(req.body)
        .then(rows => {
            if (rows.length > 0) {
                res.statusCode = 409;
                res.end('Tên đăng nhập đã tồn tại.');
            } else {
                return accountsRepo.add(req.body)
                    .then(value => {
                        console.log(value);
                        res.statusCode = 201;
                        res.json({
                            success: true,
                            msg: "Đăng ký thành công."
                        });
                    })
            }
        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
});

router.post('/login', (req, res) => {
    accountsRepo.validateCredentials(req.body)
        .then(rows => {
            if (rows.length > 0) {
                accountEntity = rows[0];
                res.json({
                    msg: "Đăng nhập thành công"
                })
            } else {
                res.statusCode = 401;
                res.end('Sai thông tin tên đăng nhập hoặc mật khẩu');
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
    accountsRepo.loadSingle(id)
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