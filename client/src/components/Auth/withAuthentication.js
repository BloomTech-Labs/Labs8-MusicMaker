import React from 'react';
import { withRouter } from 'react-router-dom';

import AuthUserContext from './AuthUserContext';
import { firebase } from '../../firebase';
import * as routes from '../Routes/routes';

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
                    // if (authUser === null) {
                    //     // this needs to route to a page saying they don't have access here, set to LANDING for now
                    //     this.props.history.push(routes.LANDING);
                    // } else return;
            });
        }

        render() {
            const { authUser } = this.state;

            return(
                <AuthUserContext.Provider value={authUser}>
                    {console.log('withAuth', authUser)}
                    <Component { ...this.props } />
                </AuthUserContext.Provider>
            );
        }
    }

    return withRouter(WithAuthentication);
}

export default withAuthentication;