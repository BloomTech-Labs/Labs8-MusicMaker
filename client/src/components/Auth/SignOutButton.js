//Signs you out once already logged in.
import React from 'react';
import { withRouter } from 'react-router-dom';

import { auth } from '../../firebase';
import withAuthentication from './withAuthentication';
import * as routes from '../Routes/routes';
import { ButtonsContainer, Button } from '../Navigation/NavBarStyle';


class SignOutButton extends React.Component {
    redirect = () => {
        auth.doSignOut();
        if (!withAuthentication.authUser || withAuthentication.authUser === null) this.props.history.push(routes.LANDING);
    }

    render() {
        return (
            <ButtonsContainer>
                <Button onClick={ this.redirect } style={{marginTop:"-0.5rem"}}>Log Out</Button>
            </ButtonsContainer>
        );
    }
}

export default withRouter(SignOutButton);
