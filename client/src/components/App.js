import React, { Component } from "react";
import { Route } from "react-router-dom";
import withAuthentication from "./withAuthentication";

import * as routes from "../constants/routes";
import Sidebar from "../components/SideBar";
import Navigation from "./Navigation";
import LandingPageView from "../views/landingView";
import SignUpView from "../views/signupView";
import SignInView from "../views/signinView";
import DashboardView from "../views/dashboardView";
import StudentListView from "../views/studentListView";
import DashboardAssignmentsView from "../views/dashboardAssignmentsView";
import CreateAssignmentView from "../views/createAssignmentView";
import DashboardBillingView from "../views/dashboardBillingView";
import DashboardSettingView from "../views/dashboardSettingView";
import GradeAssignmentView from "../views/gradeAssignmentView";

class App extends Component {
  render() {
    return (
      <div className="container">
        <div className='d-lg-block'>
          <Navigation />
        </div>

        <div className="d-lg-flex" lg="auto">
          <Sidebar />
          <Route exact path={routes.LANDING} component={LandingPageView} />
          <Route exact path={routes.SIGN_UP} component={SignUpView} />
          <Route exact path={routes.SIGN_IN} component={SignInView} />
          <Route exact path={routes.DASHBOARD} component={withAuthentication(DashboardView)} />
          <Route exact path={routes.STUDENTS} component={withAuthentication(StudentListView)} />
          <Route
            exact
            path={routes.CREATE_ASSIGNMENT}
            component={withAuthentication(CreateAssignmentView)}
          />
          <Route
            exact
            path={routes.ASSIGNMENTS}
            component={withAuthentication(DashboardAssignmentsView)}
          />
          <Route exact path={routes.BILLING} component={withAuthentication(DashboardBillingView)} />
          <Route
            exact
            path={routes.SETTINGS}
            component={withAuthentication(DashboardSettingView)}
          />
          <Route exact path={routes.GRADING} component={withAuthentication(GradeAssignmentView)} />
        </div>
      </div>
    );
  }
}

export default (App);
