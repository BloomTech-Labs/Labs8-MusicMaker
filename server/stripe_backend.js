// THE FOLLOWING CODE IS FOR THE MAIN SERVER.JS FILE, ADDING IT
// TO A SEPARATE FILE HERE TO AVOID ISSUES

const cors = require('cors'); // unnecessary as the main server file already has this
const bodyParser = require('body-parser');

const CORS_WHITELIST = require('./constants/frontend'); // this is default, use whichever location the FRONTEND_DEV_URLS and FRONTEND_PROD_URLS are placed

const corsOptions = {
  origin: (origin, callback) =>
    (CORS_WHITELIST.indexOf(origin) !== -1)
      ? callback(null, true)
      : callback(new Error('Operation not allowed by CORS.'))
};

const configureServer = app => {
  app.use(cors(corsOptions));
  app.use(bodyParser.json());
};

module.exports = configureServer;

// THESE ARE STRIPE ROUTES, ALSO TO BE ADDED WITH OTHER SERVER CODE
// ALSO (OBVIOUSLY) REQUIRES STRIPE IMPORT

const postStripeCharge = res => (stripeErr, stripeRes) => {
  if(stripeErr) {
    res.status(500).send({ error: stripeErr });
  } else {
    res.status(200).send({ success: stripeRes });
  }
}
