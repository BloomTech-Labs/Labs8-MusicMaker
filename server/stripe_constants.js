const configureStripe = require('stripe');

const STRIPE_SECRET_KEY = process.env.NODE.ENV === 'production'
  ? 'live key' // add live key from Stripe API keys dashboard to this field
  ? 'test key'; // add live key from Stripe API keys dashboard to this field
