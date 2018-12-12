//Student List View: This page will allow teacher's to view a list of all of their students.

import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';
// import { Route } from "react-router-dom";

// import * as routes from "../constants/routes";
// import StudentAssignmentsView from "./studentAssignmentsView";


class StudentListView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      students: []
    };
};

componentDidMount() {
  const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;

  axios
      .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/students`)
      .then(res => {
          this.setState({students: res.data})
      })
      .catch(err => console.error('STUDENT LIST VIEW AXIOS:', err));
}

  render() {
    return (
      <div>
        <h1><Label>Students</Label></h1>
        {/* <div style={{display:"flex", flexWrap:"wrap", flexDirection:"row"}}>
          {this.state.students.map(student => (
            <Card key={student[0]} style={{ width:"40%", margin:"1%"}}>
              <NavLink to={`/studentAssignments/${student[0]}`} style={{textDecoration:"none", color:"black"}}>
                <CardTitle>{student[1].firstName} {student[1].lastName}</CardTitle>
                <CardText>{student[1].instrument}</CardText>
                <CardText>{student[1].level}</CardText>
                <CardText>{student[1].email}</CardText>
              </NavLink> 
            </Card>
          ))}
        </div> */}
        {/* <Route path={'/studentAssignments/:studentId'} component={StudentAssignmentsView} /> */}
      </div>
    );
  }
}

export default StudentListView;