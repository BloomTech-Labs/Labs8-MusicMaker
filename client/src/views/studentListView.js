import React, { Component} from 'react';
import { Route, NavLink } from 'react-router-dom';

import SignOutButton from '../components/SignOutButton';
import DashbardNavigation from '../components/DashboardNavigation';
import SideBar from '../components/SideBar';

class StudentListView extends Components {
    state = {
        students: []
    }

    render() {
        return(
            <div className="sudentlist-view">
                <h1>Students</h1>
                    <nav>
                        <DashbardNavigation />
                        <SignOutButton />
                    </nav>
                    <SideBar />
                <div className="studentList">
                    {this.state.students.map(student => 
                        <div key={sudent.id}>
                            <NavLink to={`/studentView/${student.id}`}>
                                <h3>{student.firstName} {student.lastName}:</h3>
                                <h3>{student.instrument}</h3>
                                <h3>{student.level}</h3>
                            </NavLink>
                        </div>
                    )}
                </div>
            </div>
            
        )
    }
} 

export default StudentListView;