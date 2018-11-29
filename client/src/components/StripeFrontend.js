import React from 'react'
import { CardElement, injectStripe } from 'react-stripe-elements';

class TakeMoney extends React.Component {
  constructor(props) {
    super(props);
    this.state = { complete: false };
    this.submit = this.submit.bind(this);
  }

  async submit(ev) {
    let { token } = await this.props.stripe.createToken({ name: "Name" });
    let response = await fetch('/charge', {
      method: 'POST',
      headers: {'Content-Type': 'text/plain'},
      // body: token.id
    });
    console.log(token);

    if(response.ok) console.log("Purchase completed.");
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