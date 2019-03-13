// Assignments List: This page will allow teachers to see a list of all their ungraded assignments

import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardText, CardTitle } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';
// import { Route } from "react-router-dom";

// import * as routes from "../constants/routes";
// import StudentAssignmentsView from "./studentAssignmentsView";

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

class DashboardAssignmentsView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      assignments: []
    };
};

componentDidMount() {
  firebase.auth().onAuthStateChanged(user => {
    if (user) {
      // User is signed in.
      axios
      .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/assignments`)
      .then(res => {
          this.setState({assignments: res.data})
      })
      .catch(err => console.error('ASSIGNMENTS LIST VIEW AXIOS:', err));
    } else {
      // No user is signed in.
      return;
    }
  });
};

  render() {
    return (
      <div style={formContainer}>
        <h1 style={{padding: "20px"}}><Label>Assignments</Label></h1>
        <div style={{display:"flex", flexWrap:"wrap", flexDirection:"row"}}>
          {this.state.assignments.map(assignment => (
            <Card key={assignment[0]} style={{ width:"40%", margin:"5%", marginBottom: "4%", padding: "3.5%", border: "1px solid #A9E8DC"}}>
              <NavLink to={`/assignmentStudents/${assignment[0]}`} style={{textDecoration:"none", color:"black"}}>
                <CardTitle style={{paddingTop:"6px"}}>{assignment[1].assignmentName}</CardTitle>
                <CardText>Experience: {assignment[1].level}</CardText>
                <CardText>Instrument: {assignment[1].instrument}</CardText>
                <CardText>Piece: {assignment[1].piece}</CardText>
                <CardText>Instructions: {assignment[1].instructions.substring(0,35)}...</CardText>
              </NavLink>
              <CardText style={{padding:"15px 0 6px 0"}}>Music Sheet: <a href={assignment[1].sheetMusic}>pdf image</a></CardText> 
            </Card>
          ))}
        </div>
        {/* <Route path={'/assignmentStudents/:assignmentId'} component={StudentAssignmentsView} /> */}
      </div>
    );
  }
}

export default DashboardAssignmentsView;
