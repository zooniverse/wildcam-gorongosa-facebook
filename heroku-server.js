// Server file for running on Heroku. Probably won't be used in production, but
// simplifies the dev / testing process.

console.log('Running Heroku server...');

var express = require('express');
var morgan = require('morgan');

// Constants
var PORT = process.env.PORT || 8080;

// App
var app = express();

app.use(morgan('dev'));

app.use('/', express.static('./public/build'));

app.listen(PORT, function () {
    console.log('Running on http://localhost:' + PORT);
});