import React from "react";
import axios from "axios";
import { withRouter } from 'react-router-dom';

import PaidUserContext from "./PaidUserContext";
import * as routes from '../Routes/routes';

const withPayment = Component => {
  class WithPayment extends React.Component {
    constructor(props) {
      super(props);

      this.state = {
        subscribed: null
      };
    }

    componentDidMount() {
        const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;

        axios
        .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/settings`)
        .then(res => {
            if (res.data.subscribed != true) {
                // this needs to route to a page saying they need to subscribe, set to DASHBOARD for now
                this.props.history.push(routes.BILLING)
            } else return;
        })
        .catch(err => console.error(err));
    }

    render() {
      const { subscribed } = this.state;

      return (
        <PaidUserContext.Provider value={subscribed}>
          <Component {...this.props} />
        </PaidUserContext.Provider>
      );
    }
  }

  return withRouter(WithPayment);
};

export default withPayment;
