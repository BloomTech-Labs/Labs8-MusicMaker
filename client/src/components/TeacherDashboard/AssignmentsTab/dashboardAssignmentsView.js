// Assignments List: This page will allow teachers to see a list of all their ungraded assignments
import React, { Component } from "react";
import { NavLink, Link } from "react-router-dom";
import { Card, CardText, CardTitle } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';

// import * as routes from "../../Routes/routes";
import { AssignmentsContainer, CardsContainer, H2 } from "./ViewAllAssignmentsStyling";
import { CreateAssignment } from "../HomeTab/HomeStyling"
// import StudentAssignmentsView from "./studentAssignmentsView";


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
      <AssignmentsContainer>
        <H2>Assignments</H2>
        <Link to="/assignments/createAssignment"><CreateAssignment style={{margin:"1rem 0 0 48%"}}> + </CreateAssignment></Link>
        <CardsContainer>
          {this.state.assignments.map(assignment => (
            <Card key={assignment[0]} style={{ width:"20%", margin:"2.5%", padding:"1.5%", border: "1px solid #A9E8DC"}}>
              <NavLink to={`/assignmentStudents/${assignment[0]}`} style={{textDecoration:"none", color:"black"}}>
                <CardTitle style={{paddingTop:"6px"}}>{assignment[1].assignmentName}</CardTitle>
                <CardText>Experience: {assignment[1].level}</CardText>
                <CardText>Instrument: {assignment[1].instrument}</CardText>
                <CardText>Piece: {assignment[1].piece}</CardText>
                <CardText style={{paddingBottom:"12px"}}>Instructions: {assignment[1].instructions.substring(0,35)}...</CardText>
              </NavLink>
              <CardText>Music Sheet: <a href={assignment[1].sheetMusic}>pdf image</a></CardText> 
            </Card>
          ))}
        </CardsContainer>
        {/* <Route path={'/assignmentStudents/:assignmentId'} component={StudentAssignmentsView} /> */}
      </AssignmentsContainer>
    );
  }
}

export default DashboardAssignmentsView;
