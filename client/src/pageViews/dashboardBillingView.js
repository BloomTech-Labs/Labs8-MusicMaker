import React, { Component } from "react";
import { Elements, StripeProvider } from "react-stripe-elements";

import TakeMoney from "../components/Stripe/StripeFrontend";

import { Row, Col } from "reactstrap";

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

class DashboardBillingView extends Component {
  render() {
    return (
      <StripeProvider apiKey="pk_test_YVKiLW0mvujdoxalKItXwyhj">
        <Row className="container" style={formContainer}>
          <Col style={{padding: "20px"}}>
            <h1>Billing</h1>
            <Elements style={{padding: "20px"}}>
              <TakeMoney />
            </Elements>
          </Col>
        </Row>
      </StripeProvider>
    );
  }
}

export default DashboardBillingView;
