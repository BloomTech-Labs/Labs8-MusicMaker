// import React from 'react';
// import axios from 'axios';
// import StripeCheckout from 'react-stripe-checkout';

// WILL ADD BOTH THESE FILES LATER, COMMENTING THESE OUT UNTIL THEN
// import STRIPE_PUBLISHABLE from './constants/stripe';
// import PAYMENT_SERVER_URL from './constants/server';

// const CURRENCY = 'USD'; // basic currency is dollars
// no conversion variable is needed

// const successPayment = data => {
//   alert('Payment successful!');
// };
//
// const errorPayment = data => {
//   alert('There was an error while processing your payment.');
// };
//
// const onToken = (amount, description) => token =>
//   axios.post(PAYMENT_SERVER_URL,
//     {
//       description,
//       source: token.id,
//       currency: CURRENCY,
//       amount: (amount)
//     })
//     .then(successPayment)
//     .catch(errorPayment);
//
// const Checkout = ({ name, description, amount }) =>
//   <StripeCheckout
//     name = {name}
//     description = {description}
//     amount = {(amount)}
//     token = {onToken(amount, description)}
//     currency = {CURRENCY}
//     stripeKey = {STRIPE_PUBLISHABLE}
//   />
//
// export default Checkout;
