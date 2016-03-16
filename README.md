# WildCam Gorongosa - Facebook

Built using:

- Gulp
- Webpack
- Coffeescript, CJSX
- React.js
- Reflux
- Stylus

---

## Installation

Clone and run `npm install`. 

## Running

So there are several different ways to get this project up and running, since I've been working in several different environments due to the HTTPS requirement for Facebook projects.

### Locally

Without HTTPS (only good for testing basic functionality in the project itself):

```shell
gulp
```

With HTTPS:

```shell
node local-server.js
```

Note that you'll need to provide your own certificate in the `cert` folder for this to work. You can generate a self-signed certificate by running:

```shell
mkdir cert
openssl req -nodes -x509 -newkey rsa:2048 -keyout cert/key.pem -out cert/cert.pem -days 365
```

You'll also need to forward the relevant port on your router, and enable it's specified in your Facebook app URL. But this method does simplify development, as changes to the codebase are reflected immediately (_as long as you're running `gulp` as well_!).

### Heroku

Just push the whole business to your Heroku app, the included `Procfile` will spin up the correct server process from `heroku-server.js`.

## Configuring

Add the URL of wherever you're hosting it to a Facebook app, and it should be good to go. It's not currently performing authentication via FB, so you don't need a secret (but you will need to set a Facebook App ID)


