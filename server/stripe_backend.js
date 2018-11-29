// THE FOLLOWING CODE IS FOR THE MAIN SERVER.JS, ADDING IT
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
