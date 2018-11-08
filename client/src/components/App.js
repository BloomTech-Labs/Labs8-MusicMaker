import React, { Component } from 'react';
import { Route } from 'react-router-dom';

import * as routes from '../constants/routes';
import { firebase } from '../firebase';

import Navigation from './Navigation';
import LandingPageView from '../views/landingView';
import SignUpView from '../views/signupView';
import SignInView from '../views/signinView';
import DashboardView from '../views/dashboardView';

import './App.css';

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      authUser: null
    };
  }

  componentDidMount() {
    firebase.auth.onAuthStateChanged(authUser => {
      authUser
        ? this.setState({ authUser })
        : this.setState({ authUser: null });
    });
  }

  render() {
    return (
      <div className="App">
        <Navigation authUser={ this.state.authUser }/>

        <Route
          exact path={ routes.LANDING }
          component={ LandingPageView }
        />
        <Route
          exact path={ routes.SIGN_UP }
          component={ SignUpView }
        />
        <Route
          exact path={ routes.SIGN_IN }
          component={ SignInView }
        />
        <Route
          exact path={ routes.DASHBOARD }
          component={ DashboardView }
        />
      </div>
    );
  }
}

export default App;