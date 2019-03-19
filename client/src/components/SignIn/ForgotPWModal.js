//Forgot password modal view
import React from 'react';
import { Button, Modal, ModalHeader, ModalBody } from 'reactstrap';

import ForgotPW from "../Auth/ForgotPW";

class ModalExample extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      modal: false
    };

    this.toggle = this.toggle.bind(this);
  }

  toggle() {
    this.setState(prevState => ({
      modal: !prevState.modal
    }));
  }

  render() {
    return (
      <div>
        <Button style={{background:"none", border:"none", margin:"0 35%" }}  onClick={this.toggle}>Forgot password?</Button>
        <Modal isOpen={this.state.modal} toggle={this.toggle} className={this.props.className}>
          <ModalHeader toggle={this.toggle} style={{ color:"#02547D" }}>Reset Password?</ModalHeader>
          <ModalBody>
            <ForgotPW />
          </ModalBody>
        </Modal>
      </div>
    );
  }
}

export default ModalExample;