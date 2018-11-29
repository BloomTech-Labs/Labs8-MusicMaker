// THIS FILE IS A TEST FOR NOW, JUST IMPLEMENTING SOME OF THE FRONT END FUNCTIONALITY FOR STRIPE
// I WILL COME BACK TO THIS LATER TO GET BOTH ENDS WORKING PROPERLY, THIS IS A TEMPLATE/REFERENCE FOR FRONT-END STRIPE WORK

import React from 'react'
import StripeCheckout from 'react-stripe-checkout';

export default class TakeMoney extends React.Component {
  onToken = (token) => {
    fetch('/save-stripe-token', {
      method: 'POST',
      body: JSON.stringify(token),
    }).then(response => {
      response.json().then(data => {
        alert(`We are in business, ${data.email}`);
      });
    });
  }

  // ...

  render() {
    return (
      // ...
      <StripeCheckout
        token={this.onToken}
        stripeKey="pk_test_YVKiLW0mvujdoxalKItXwyhj"
      />
    )
  }
}