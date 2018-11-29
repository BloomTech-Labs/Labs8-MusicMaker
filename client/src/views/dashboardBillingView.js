// general dashboard billing view, will add functionality after Stripe integration
// assuming there will be a siderbar, so I did not specifically add one in this view.

import React, { Component } from "react";

import Sidebar from "../components/SideBar";
import TakeMoney from '../components/StripeFrontend';

class DashboardBillingView extends Component {
  render() {
    return (
      <div className="container">
        <div className="flex-container">
        <Sidebar />
          <div className="block-container" id="billing">
          <h1 className="subheader">Billing</h1>
            <TakeMoney />
          </div>
        </div>
      </div> // billing-wrapper
    );
  }
}

export default DashboardBillingView;
