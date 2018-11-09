import React, { Component } from 'react';
import { Route, NavLink } from 'react-router-dom';

import SignOutButton from '../components/SignOutButton.js';

class DashboardNavigation  extends Component {
    render() {
        return(
            <div className="teacher-dashboard">
                <header className="teacher-dashboard-header"> 
                    <nav className="left-nav">
                        <NavLink exact to="/">Home</NavLink>
                        &nbsp; > &nbsp;
                        <NavLink to="/assignments">Assignments</NavLink>
                    </nav>
                    <nav className="right-nav">
                        <SignOutButton />
                    </nav>
                </header>
                <main>
                    {/* <Route exact path={Not sure if home will be the landing page or something else} component={} />
                    <Route path={routes.ASSIGNMENT} component={DashboardAssignmentView} /> */}
                </main>
            </div>
        )
    }

}
export default DashboardNavigation;