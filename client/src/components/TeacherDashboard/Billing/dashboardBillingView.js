import React, { Component } from "react";
import { Elements, StripeProvider } from "react-stripe-elements";
import { Row, Col } from "reactstrap";

import TakeMoney from "../../Stripe/StripeFrontend";


class DashboardBillingView extends Component {
  render() {
    return (
      <StripeProvider apiKey="pk_test_YVKiLW0mvujdoxalKItXwyhj">
        <Row style={{width:"50%", margin:"3.5rem 37%"}}>
          <Col>
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
