// Server file for running on Docker

console.log('Starting Docker server...');

var express = require('express');
var morgan = require('morgan');

// Constants
var PORT = process.env.PORT || 8080;

// App
var app = express();

// Provide logging with Morgan
app.use(morgan('dev'));

// Simply serves up the build folder on GET. This is only for testing, as 
// Facebook requires a POST in order to do a signed request.
app.use('/', express.static(__dirname + '/public/build'));

// Try sending back the home page
app.post('/', function(req, res, next) {
    res.sendFile(__dirname + '/public/build/index.html');
});

app.listen(PORT, function () {
    console.log('Running on http://localhost:' + PORT);
});
