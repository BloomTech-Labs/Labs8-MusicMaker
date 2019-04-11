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
        alert("Payment Success");
      })
      .catch(error => {
        alert("Payment Error");
      });
  }

  render() {
    return (
      <div style={{width:"75%", display:"block", margin:"3.5rem auto", }}>
        <Row>
          <Col>
            <h2 style={{textAlign:"center"}}>Billing</h2>
          </Col>
        </Row>

        <Row style={{display:"flex", marginTop:"3rem"}}>
          <Col>
            <CardElement />
          </Col>
          <Col>
            <Button onClick={this.submit} style={{padding:"0 5%", marginLeft:"58%", width:"40%"}}>Send</Button>
          </Col>
        </Row>
      </div>
    );
  }
}

export default injectStripe(TakeMoney);
