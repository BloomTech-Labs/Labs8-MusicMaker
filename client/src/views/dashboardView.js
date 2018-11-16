import React, { Component } from "react";
import { connect } from 'react-redux';
import { fetchTeachers } from '../actions';

// import PasswordChangeForm from "../components/UpdatePW";
import DashboardNavigaton from "../components/DashboardNavigation";
import SideBar from "../components/SideBar";

class DashboardView extends Component {
  constructor() {
    super();
    this.state = {
      teachers: []
    };
  }

  componentDidMount() {
    this.props.fetchTeachers();
    console.log(this.state.teachers);
  }

  render() {
    return (
      <div>
          <DashboardNavigaton />
          <div>New Assignment</div>
          <div> + </div>
          <SideBar />
          {/* <PasswordChangeForm /> */}

          {/* {this.props.teachers.map(teacher => {
            return (
              <div>
                <p>{teacher.firstName}</p>
                <p>{teacher.lastName}</p>
              </div>
            )
          })} */}
      </div>
    );
   }
 }
 
 export default connect(null, { fetchTeachers })(DashboardView);