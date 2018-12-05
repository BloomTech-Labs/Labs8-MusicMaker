import React, { Component } from "react";
import { Elements, StripeProvider } from "react-stripe-elements";

import Sidebar from "../components/SideBar";
import TakeMoney from "../components/StripeFrontend";

import { Row, Col } from "reactstrap";

class DashboardBillingView extends Component {
  render() {
    return (
      <StripeProvider apiKey="pk_test_YVKiLW0mvujdoxalKItXwyhj">
        <Row className="flex">
          <Col>
            <Sidebar />
          </Col>

          <Col sm="12" md={{ size: 12, order: 2, offset: 3 }}>
            <Row>
              <h1 className="display-1">Billing</h1>
            </Row>
            <Elements>
              <TakeMoney />
            </Elements>
          </Col>
        </Row>
      </StripeProvider>
    );

    //hello'fsd'd'fsf'
  }
}

export default DashboardBillingView;
