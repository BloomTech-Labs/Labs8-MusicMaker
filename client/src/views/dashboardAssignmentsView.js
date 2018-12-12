// Assignment List: This page wil allow teacher's to see a list of all their ungraded assignments
 
import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';
// import { Route } from "react-router-dom";

// import * as routes from "../constants/routes";
// import StudentAssignmentsView from "./studentAssignmentsView";


class DashboardAssignmentsView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      assignments: []
    };
};

componentDidMount() {
  const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;

  axios
      .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/assignments`)
      .then(res => {
          console.log('Axios*******************', res.data[0], res.data[1].assignmentName)
          this.setState({assignments: res.data})
      })
      .catch(err => console.error('STUDENT LIST VIEW AXIOS:', err));
}

  render() {
    return (
      <div>
        <h1><Label>Assignments</Label></h1>
        <div style={{display:"flex", flexWrap:"wrap", flexDirection:"row"}}>
          {this.state.assignments.map(assignment => (
            <Card key={assignment[0]} style={{ width:"40%", margin:"1%"}}>
              <NavLink to={`/assignmentStudents/${assignment[0]}`} style={{textDecoration:"none", color:"black"}}>
                <CardTitle>{assignment[1].assignmentName}</CardTitle>
                <CardText>Instrument: {assignment[1].instrument}</CardText>
                <CardText>Experience: {assignment[1].level}</CardText>
              </NavLink> 
            </Card>
          ))}
        </div>
        {/* <Route path={'/assignmentStudents/:assignmentId'} component={StudentAssignmentsView} /> */}
      </div>
    );
  }
}

export default DashboardAssignmentsView;