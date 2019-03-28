import React from "react";
import axios from "axios";
import { CardElement, injectStripe } from "react-stripe-elements";

import { Button, Row, Col } from "reactstrap";

class TakeMoney extends React.Component {
  constructor(props) {
    super(props);
    this.state = { complete: false };
    this.submit = this.submit.bind(this);
  }

  async submit(ev) {
    let token = await this.props.stripe.createToken();
    console.log(token);

    axios
      .post("https://musicmaker-4b2e8.firebaseapp.com/teacher/:idTeacher/charge", token)
      .then(response => {
        console.log(response);
        alert("Payment Success");
      })
      .catch(error => {
        console.log("Payment Error: ", error);
        alert("Payment Error");
      });
  }

  render() {
    return (
      <div>
        <Row>
          <Col>
            <h2 style={{margin:"0 0 2rem 19%"}}>Billing</h2>
          </Col>
        </Row>

        <Row>
          <Col style={{margin:"1.25rem 0"}}>
            <CardElement />
          </Col>
          <Col>
            <Button onClick={this.submit} style={{padding:"0 5%", margin:"1rem 0"}}>Send</Button>
          </Col>
        </Row>
      </div>
    );
  }
}

export default injectStripe(TakeMoney);
