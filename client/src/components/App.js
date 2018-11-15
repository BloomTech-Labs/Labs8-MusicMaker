import React, { Component } from 'react';
import { Route } from 'react-router-dom';
import withAuthentication from './withAuthentication';

import * as routes from '../constants/routes';

// import Navigation from './Navigation';
import LandingPageView from '../views/landingView';
import SignUpView from '../views/signupView';
import SignInView from '../views/signinView';
import DashboardView from '../views/dashboardView';
// import DashboardBillingView from '../views/dashboardBillingView';
import StudentListView from '../views/studentListView';

import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        {/* <Navigation /> */}
        <Route 
          path={ routes.STUDENTS }
          component={StudentListView}
        />
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

export default withAuthentication(App);
