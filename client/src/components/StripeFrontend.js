import React from 'react';
import axios from 'axios';
import { CardElement, injectStripe } from 'react-stripe-elements';

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
      .post("https://musicmaker-4b2e8.firebaseapp.com/charge", token )
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
    return(
      <div className="checkout">
        <p>Send payment?</p>
        <CardElement />
        <button onClick={this.submit}>Send</button>
      </div>
    );
  }
}

export default injectStripe(TakeMoney);