import React, { Component } from "react";
import { Elements, StripeProvider } from "react-stripe-elements";
import { Row, Col } from "reactstrap";

import TakeMoney from "./StripeFrontend";


class DashboardBillingView extends Component {
  render() {
    return (
      <StripeProvider apiKey="pk_test_YVKiLW0mvujdoxalKItXwyhj">
        <Row style={{width:"50%", margin:"3.5rem auto", background:"#EBFAEF", border:"1px solid #a9e8dc"}}>
          <Col>
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
