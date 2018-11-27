// general dashboard billing view, will add functionality after Stripe integration
// assuming there will be a siderbar, so I did not specifically add one in this view.

import React, { Component } from "react";

import Sidebar from "../components/SideBar";

class DashboardBillingView extends Component {
  render() {
    return (
      <div className="container">
        <div className="flex-container">
        <Sidebar />
          <div className="block-container" id="billing">
          <h1 className="subheader">Billing</h1>
            <div>
              <input
                className="bodyText"
                type="text"
                placeholder="Card Number"
                // value and event handlers to follow
              />
            </div>
            <div>
              <input
                className="bodyText"
                type="month"
                placeholder="Expiration Date"
                // value and event handlers to follow
              />
              <input
                className="bodyText"
                type="text"
                placeholder="CVV"
                // value and event handlers to follow
              />
            </div>
            <div>
              <div>
                <input
                  className="bodyText"
                  type="checkbox"
                  name="option1"
                  value="monthly"
                />{" "}
                1 Month Subscription - $20
                <br />
                <input
                  className="bodyText"
                  type="checkbox"
                  name="option2"
                  value="oneclient"
                />{" "}
                1 Client - $1.99
                <br />
              </div>
              <button className="buy-button">Buy Now</button>
            </div>
          </div>
        </div>
      </div> // billing-wrapper
    );
  }
}

export default DashboardBillingView;
