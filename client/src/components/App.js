// Displays components and pageViews
import React, { Component } from "react";
import { Route } from "react-router-dom";

import withAuthentication from "./Auth/withAuthentication";

import withPayment from './Stripe/withPayment';

import * as routes from "./Routes/routes";
import Sidebar from "../components/SideBar";
import Navigation from "./Navigation";
import LandingPageView from "../pageViews/landingView";
import SignUpView from "../pageViews/signupView";
import SignInView from "../pageViews/signinView";
import DashboardView from "../pageViews/dashboardView";
import StudentListView from "../pageViews/studentListView";
import DashboardAssignmentsView from "../pageViews/dashboardAssignmentsView";
import CreateAssignmentView from "../pageViews/createAssignmentView";
import DashboardBillingView from "../pageViews/dashboardBillingView";
import DashboardSettingView from "../pageViews/dashboardSettingView";
import GradeAssignmentView from "../pageViews/gradeAssignmentView";
import StudentAssignmentsView from "../pageViews/studentAssignmentsView"
import AssignmentStudentsView from "../pageViews/assignmentStudentsView"

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
          <Route exact path={routes.DASHBOARD} component={DashboardView} />
          <Route exact path={routes.STUDENTS} component={StudentListView} />
          <Route exact path={routes.STUDENTSASSIGNMETS} component={StudentAssignmentsView} />

          <Route exact path={routes.CREATE_ASSIGNMENT} component={CreateAssignmentView} />
          <Route exact path={routes.ASSIGNMENTS} component={DashboardAssignmentsView} />
          <Route exact path={routes.ASSIGNMENT_STUDENTS} component={AssignmentStudentsView} />
          <Route exact path={routes.BILLING} component={DashboardBillingView} />
          <Route exact path={routes.SETTINGS} component={DashboardSettingView} />
          <Route exact path={routes.GRADING} component={withPayment(GradeAssignmentView)} />
        </div>
      </div>
    );
  }
}

export default withAuthentication(App);
