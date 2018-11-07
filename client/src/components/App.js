import React, { Component } from 'react';
import { Route } from 'react-router-dom';

import * as routes from '../constants/routes';

import Navigation from './Navigation';
import landingView from '../views/landingView';
import signupView from '../views/signupView';
import signinView from '../views/signinView';

import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <Navigation />

        <Route
          exact path={ routes.LANDING }
          component={ landingView }
        />

        <Route
          exact path={ routes.SIGN_UP }
          component={ signupView }
        />

        <Route
          exact path={ routes.SIGN_IN }
          component={ signinView }
        />
      </div>
    );
  }
}

export default App;