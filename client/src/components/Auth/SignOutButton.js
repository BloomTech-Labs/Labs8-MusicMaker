//Signs you out once already logged in.
import React from 'react';
import { withRouter } from 'react-router-dom';

import { auth } from '../../firebase';
import withAuthentication from './withAuthentication';
import * as routes from '../Routes/routes';
import { Button } from '../Navigation/NavBarStyle';

class SignOutButton extends React.Component {
    constructor(props) {
        super(props);
    }

    redirect = () => {
        auth.doSignOut();
        if (!withAuthentication.authUser || withAuthentication.authUser === null) this.props.history.push(routes.LANDING);
    }

    render() {
        return (
            <Button onClick={ this.redirect }>Log Out</Button>
        );
    }
}

export default withRouter(SignOutButton);
