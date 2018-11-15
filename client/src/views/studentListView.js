import React, { Component} from 'react';
import { NavLink } from 'react-router-dom';

import DashbardNavigation from '../components/DashboardNavigation';
import SideBar from '../components/SideBar';

class StudentListView extends Component {
    state = {
        students: []
    }

    render() {
        return(
            <div className="studentlist-view">
                <DashbardNavigation />
                <SideBar />
                <h1>Students</h1>
                <div className="studentList">
                    {this.state.students.map(student => 
                        <div key={student.id}>
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