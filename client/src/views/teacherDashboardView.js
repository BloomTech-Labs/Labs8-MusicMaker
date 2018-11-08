import React, { Component } from 'react';
import { Route, NavLink } from 'react-router-dom';

import SignOutButton from '../components/SignOutButton.js';

class TeacherDashboardView  extends Component {
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
                    {/* <Route exact path="/" component={} />
                    <Route path="/assignment" component={Home} /> */}
                </main>
            </div>
        )
    }

}

export default TeacherDashboardView;