//Student List View: This page will allow teacher's to view a list of all of their students.

import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';
import { Route } from "react-router-dom";
import firebase from 'firebase';

import * as routes from "../constants/routes";
import StudentAssignmentsView from "./studentAssignmentsView";

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

class StudentListView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      students: []
    };
};

componentDidMount() {
  const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;
  firebase.auth().onAuthStateChanged(user => {
    if (user) {
      // User is signed in.
  axios
  .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/students`)
  .then(res => {
      this.setState({students: res.data})
  })
  .catch(err => console.error('STUDENT LIST VIEW AXIOS:', err));
    } else {
      // No user is signed in.
      return;
    }
  });
}

  render() {
    return (
      <div className="container" style={formContainer}>
        <h1><Label style={{margin: "15px"}}>Students</Label></h1>
        <div style={{display:"flex", flexWrap:"wrap", flexDirection:"row"}}>
          {this.state.students.map(student => (
            <Card key={student[0]} style={{ width:"40%", margin:"2.5%", marginBottom: "4%", padding: "1.5%", border: "1px solid #A9E8DC"}}>
              <NavLink to={`/studentAssignments/${student[0]}`} style={{textDecoration:"none", color:"black"}}>
                <CardTitle>{student[1].firstName} {student[1].lastName}</CardTitle>
                <CardText>{student[1].instrument}</CardText>
                <CardText>{student[1].level}</CardText>
                <CardText>{student[1].email}</CardText>
              </NavLink>
            </Card>
          ))}
        </div>
        <Route path={routes.STUDENTSASSIGNMETS} component={StudentAssignmentsView} />
      </div>
    );
  }
}

export default StudentListView;
