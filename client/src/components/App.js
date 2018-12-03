import React, { Component } from "react";
import { Route } from "react-router-dom";
import withAuthentication from "./withAuthentication";

import * as routes from "../constants/routes";
import Navigation from "./Navigation";
import LandingPageView from "../views/landingView";
import SignUpView from "../views/signupView";
import SignInView from "../views/signinView";
import DashboardView from "../views/dashboardView";
import StudentListView from "../views/studentListView";
import DashboardAssignmentsView from '../views/dashboardAssignmentsView';
import CreateAssignmentView from '../views/createAssignmentView';
import DashboardBillingView from "../views/dashboardBillingView";
import DashboardSettingView from "../views/dashboardSettingView";
import GradeAssignmentView from "../views/gradeAssignmentView";

class App extends Component {
  render() {
    return (
      <div className="App">
        <Navigation />
        <Route exact path={routes.LANDING} component={LandingPageView} />
        <Route exact path={routes.SIGN_UP} component={SignUpView} />
        <Route exact path={routes.SIGN_IN} component={SignInView} />
        <Route exact path={routes.DASHBOARD} component={DashboardView} />
        <Route exact path={routes.STUDENTS} component={StudentListView} />
        <Route exact path={routes.CREATE_ASSIGNMENT} component={CreateAssignmentView} />
        <Route exact path={routes.ASSIGNMENTS} component={DashboardAssignmentsView} />
        <Route exact path={routes.BILLING} component={DashboardBillingView} />
        <Route exact path={routes.SETTINGS} component={DashboardSettingView} />
        <Route exact path={routes.GRADING} component={GradeAssignmentView} />
      </div>
    );
  }
}

export default withAuthentication(App);
