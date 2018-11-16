// THIS FILE IS A TEST FOR NOW, JUST IMPLEMENTING SOME OF THE FRONT END FUNCTIONALITY FOR STRIPE
// I WILL COME BACK TO THIS LATER TO GET BOTH ENDS WORKING PROPERLY, THIS IS A TEMPLATE/REFERENCE FOR FRONT-END STRIPE WORK

import React, { Component } from 'react';
// import Checkout from './Checkout'; will un-comment this when necessary
import './App.css';

class StripeFrontend extends Component {
  render() {
    return (
      <div className = 'checkout-wrapper'>
        <Checkout name = {'Test Checkout'}
                  description = {'Stripe front end test.'}
                  amount = {1}
        />
      </div>
    );
  }
}
