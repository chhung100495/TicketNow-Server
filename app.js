var moviesCtrl = require('./controllers/moviesCtrl');
var accountsCtrl = require('./controllers/accountsCtrl');
var usersCtrl = require('./controllers/usersCtrl');

var express = require('express'),
    morgan = require('morgan'),
    bodyParser = require('body-parser'),
    cors = require('cors');

var app = express();
app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(cors());

var host = '0.0.0.0';
var port = process.env.PORT || 4000;
app.listen(port, host, () => {
    console.log(`API running on port ${port}`);
})

app.use('/movies', moviesCtrl);
app.use('/accounts', accountsCtrl);
app.use('/users', usersCtrl);