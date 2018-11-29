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
    // let response = await fetch('/charge', {
    //   method: 'POST',
    //   headers: {'Content-Type': 'text/plain'},
    //   body: token.id
    // });
    console.log(token);

    axios
      .post("http://localhost:8000/charge", token )
      .then(response => {
        console.log(response);
        alert("Payment Success");
      })
      .catch(error => {
        console.log("Payment Error: ", error);
        alert("Payment Error");
      });

    // if(response.ok) console.log("Purchase completed.");
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