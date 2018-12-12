import React from 'react';
import { withRouter } from 'react-router-dom';

import AuthUserContext from './AuthUserContext';
import { firebase } from '../firebase';
import * as routes from '../constants/routes';

const withAuthentication = (Component) => {
    class WithAuthentication extends React.Component {
        constructor(props) {
            super(props);

            this.state = {
                authUser: null,
            };
        }

        componentDidMount() {
            firebase.auth.onAuthStateChanged(authUser => {
                authUser
                    ? this.setState({ authUser })
                    : this.setState({ authUser: null });

                // if(!this.state.authUser || this.state.authUser === null) this.props.history.push(routes.SIGN_IN);
            });
        }

        render() {
            const { authUser } = this.state;

            return(
                <AuthUserContext.Provider value={authUser}>
                    <Component { ...this.props } />
                </AuthUserContext.Provider>
            );
        }
    }

    return withRouter(WithAuthentication);
}

export default withAuthentication;