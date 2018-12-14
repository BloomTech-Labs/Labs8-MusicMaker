import React from 'react';
import { Button } from 'reactstrap';
import { withRouter } from 'react-router-dom';

import { auth } from '../firebase';
import withAuthentication from './withAuthentication';
import * as routes from '../constants/routes';

class SignOutButton extends React.Component {
    constructor(props) {
        super(props);
    }

    redirect = () => {
        auth.doSignOut();
        if (!withAuthentication.authUser || withAuthentication.authUser === null) this.props.history.push(routes.SIGN_IN);
    }

    render() {
        return (
            <Button color="primary" onClick={ this.redirect } style={{position: "relative", right: "5.5%"}}>Sign Out</Button>
        );
    }
}

export default withRouter(SignOutButton);
