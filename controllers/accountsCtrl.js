var express = require('express');
var accountsRepo = require('../repositories/accountsRepo');

var router = express.Router();

router.post('/register', (req, res) => {
    accountsRepo.checkUsernameAvailability(req.body)
        .then(rows => {
            if (rows.length > 0) {
                res.statusCode = 409;
                res.end('Tên đăng nhập đã tồn tại');
            } else {
                return accountsRepo.add(req.body)
                    .then(values => {
                        console.log(values);
                        if (values[0].affectedRows != 0 && values[1].affectedRows != 0) {
                            res.statusCode = 201;
                            res.json({
                                result: [{id: values[1].insertId}]
                            });
                        }
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
                results = {
                    result: [{
                        "id": rows[0].id,
                        "username": rows[0].username,
                        user: {
                            "id": rows[0].user_id,
                            "full_name": rows[0].full_name,
                            "gender": rows[0].gender,
                            "birthday": rows[0].birthday,
                            "email": rows[0].email,
                            "phone": rows[0].phone,
                            "address": rows[0].address
                        }
                    }]
                };
                res.json(results);
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

router.post('/changePassword', (req, res) => {
    accountsRepo.changePassword(req.body)
        .then(value => {
            if (value.affectedRows == 1) {
                res.json({
                    msg: "Thay đổi mật khẩu thành công"
                })
            } else {
                res.statusCode = 400;
                res.end('Thay đổi mật khẩu thất bại');
            }

        })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.end('View error log on server console');
        })
});

module.exports = router;