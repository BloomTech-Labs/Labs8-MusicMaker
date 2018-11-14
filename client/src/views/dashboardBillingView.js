// general dashboard billing view, will add functionality after Stripe integration
// assuming there will be a siderbar, so I did not specifically add one in this view.

import React, { Component } from 'react';

class DashboardBillingView extends Component {
  render() {
    return (
      <div className = 'billing-wrapper'>
        <h1>Billing</h1>
        <div className = 'payment-info-box'>

          <input type = 'text'
                 placeholder = 'Card Number'
                 // value and event handlers to follow
          />
          <input type = 'text'
                 placeholder = 'Expiration Date'
                 // value and event handlers to follow
          />
          <input type = 'text'
                 placeholder = 'CVV'
                 // value and event handlers to follow
          />

        </div> // payment-info-box
        <div className = 'subscription-text'>
          <input type = 'checkbox' name = 'option1' value = 'monthly'> 1 Month Subscription - $20</br>
          <input type = 'checkbox' name = 'option2' value = 'oneclient'> 1 Client - $1.99</br>
        </div>
        <button className = 'buy-button'>Buy Now</button>
      </div> // billing-wrapper
    );
  }
}

export default DashboardBillingView;
