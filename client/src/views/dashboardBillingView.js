import React, { Component } from "react";
import { Elements, StripeProvider } from "react-stripe-elements";

import TakeMoney from "../components/StripeFrontend";

import { Row, Col } from "reactstrap";

class DashboardBillingView extends Component {
  render() {
    return (
      <StripeProvider apiKey="pk_test_YVKiLW0mvujdoxalKItXwyhj">
        <Row className="container">
          <Col>
            <h1>Billing</h1>
            <Elements>
              <TakeMoney />
            </Elements>
          </Col>
        </Row>
      </StripeProvider>
    );
  }
}

export default DashboardBillingView;
