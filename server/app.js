//Imports private data such as API keys and passwords
require('dotenv').config()
const express = require('express')
const bodyParser = require('body-parser')
const http = require('http')
// const https = require('https')
const coBorrow = require('./routes/checkout/borrowed.js')
const coLent = require('./routes/checkout/lent.js')
const coRequest = require('./routes/checkout/requests.js')
const coWishlist = require('./routes/checkout/wishlist.js')
const library = require('./routes/library/library.js')
const login = require('./routes/login/login.js')
const map = require('./routes/map/map.js')
const signup = require('./routes/signup/signup.js')
const userAbout = require('./routes/user/about.js')
const changeAddr = require('./routes/user/changeAddr.js')
const changePW = require('./routes/user/changePW.js')
const userPic = require('./routes/user/pic.js')
const user = require('./routes/user/user.js')
const app = express()

//CORS

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', "*");
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
});

//Parse incoming data

app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

//Routes

//Checkout
app.use(coBorrow)
app.use(coLent)
app.use(coRequest)
app.use(coWishlist)
//Library
app.use(library)
//Login
app.use(login)
//Map
app.use(map)
//Signup
app.use(signup)
//User
app.use(userAbout)
app.use(changeAddr)
app.use(changePW)
app.use(userPic)
app.use(user)

//Starts the server at the designated port and console logs when it's running

http.createServer(app).listen(process.env.HTTP_PORT, () => {
    console.log(`Http server started on port ${process.env.HTTP_PORT}`);
});
// https.createServer(app).listen(process.env.HTTPS_PORT, () => {
//     console.log(`Http server started on port ${process.env.HTTPS_PORT}`);
// });