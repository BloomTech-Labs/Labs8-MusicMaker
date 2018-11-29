// // THE FOLLOWING CODE IS FOR THE MAIN SERVER.JS FILE, ADDING IT
// // TO A SEPARATE FILE HERE TO AVOID ISSUES
//
// const cors = require('cors'); // unnecessary as the main server file already has this
// const bodyParser = require('body-parser');
//
// const CORS_WHITELIST = require('./constants/frontend'); // this is default, use whichever location the FRONTEND_DEV_URLS and FRONTEND_PROD_URLS are placed
//
// const corsOptions = {
//   origin: (origin, callback) =>
//     (CORS_WHITELIST.indexOf(origin) !== -1)
//       ? callback(null, true)
//       : callback(new Error('Operation not allowed by CORS.'))
// };
//
// const configureServer = app => {
//   app.use(cors(corsOptions));
//   app.use(bodyParser.json());
// };
//
// module.exports = configureServer;
//
// // THESE ARE STRIPE ROUTES, ALSO (OBVIOUSLY) REQUIRES STRIPE IMPORT
// // CAN BE ADDED IN A FILE CALLED PAYMENT.JS
//
// const postStripeCharge = res => (stripeErr, stripeRes) => {
//   if(stripeErr) {
//     res.status(500).send({ error: stripeErr });
//   } else {
//     res.status(200).send({ success: stripeRes });
//   }
// }
//
// // the exact route endpoints here can obviously be edited as desired
//
// const paymentApi = app => {
//   app.get('/stripeTest', (req, res) => {
//     res.send({ message: 'Stripe backend test message!', timestamp: new Date().toISOstring() })
//   }); // timestamp is not necessary if it causes problems
//
//   app.post('/subscribe', (req, res) => {
//     stripe.charges.create(req.body, postStripeCharge(res));
//   });
//
//   return app;
// };
//
// module.exports = paymentApi;
//
// // call the payment.js file first (or wherever it's saved) as an import in the main server code:
//
// const paymentApi = require('./payment'); // or other file path
//
// const configureRoutes = app => {
//   paymentApi(app);
// };
//
// // use the following if exporting somewhere and the above code is not in the main server file
//
// module.exports = configureRoutes;
