// Server file for running locally.

console.log('Running local server...');

var fs = require('fs');
var https = require('https');
var express = require('express');
var morgan = require('morgan');

// Constants
var PORT = process.env.PORT || 8080;
var HOST = process.env.HOST || '';

// App
var app = express();

// Provide logging with Morgan
app.use(morgan('dev'));

// Simply serves up the build folder on GET. This is only for testing, as 
// Facebook requires a POST in order to do a signed request.
app.use('/', express.static('./public/build'));

// Try sending back the home page
app.post('/', function(req, res, next) {
    res.sendFile(__dirname + '/public/build/index.html');
});

var options = {
    key: fs.readFileSync('./cert/key.pem'),
    cert: fs.readFileSync('./cert/cert.pem'),
};

https.createServer(options, app).listen(PORT, HOST, null, function() {
    console.log('Server listening on port %d in %s mode', this.address().port, app.settings.env);
});
