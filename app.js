var moviesCtrl = require('./controllers/moviesCtrl');
var accountsCtrl = require('./controllers/accountsCtrl');
var usersCtrl = require('./controllers/usersCtrl');
var bookingsCtrl = require('./controllers/bookingsCtrl');
var bookedSeatsCtrl = require('./controllers/bookedSeatsCtrl');
var bookedCombosCtrl = require('./controllers/bookedCombosCtrl');
var seatsCtrl = require('./controllers/seatsCtrl');
var notificationsCtrl = require('./controllers/notificationsCtrl');
var cineplexCtrl = require('./controllers/cineplexCtrl');
var venuesCtrl = require('./controllers/venuesCtrl');
var cinemasCtrl = require('./controllers/cinemasCtrl');
var eventsCtrl = require('./controllers/eventsCtrl');

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
app.use('/bookings', bookingsCtrl);
app.use('/bookedSeats', bookedSeatsCtrl);
app.use('/bookedCombos', bookedCombosCtrl);
app.use('/seats', seatsCtrl);
app.use('/notifications', notificationsCtrl);
app.use('/cineplex', cineplexCtrl);
app.use('/cinemas', cinemasCtrl);
app.use('/venues', venuesCtrl);
app.use('/events', eventsCtrl);