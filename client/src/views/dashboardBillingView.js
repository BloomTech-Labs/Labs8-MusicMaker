import React, { Component } from "react";
import { Elements, StripeProvider } from "react-stripe-elements";

import Sidebar from "../components/SideBar";
import TakeMoney from "../components/StripeFrontend";

class DashboardBillingView extends Component {
  render() {
    return (
      <StripeProvider apiKey="pk_test_YVKiLW0mvujdoxalKItXwyhj">
        <div className="container">
          <div className="flex-container">
            <Sidebar />
            <div className="block-container" id="billing">
              <h1 className="subheader">Billing</h1>
              <Elements>
                <TakeMoney />
              </Elements>
            </div>
          </div>
        </div>
      </StripeProvider>
    );
  }
}

export default DashboardBillingView;
