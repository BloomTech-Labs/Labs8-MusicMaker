//Student List View: This page will allow teacher's to view a list of all of their students.

import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Card, CardText, CardTitle } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';

import { AssignmentsContainer, H2, CardsContainer }  from "../AssignmentsTab/ViewAllAssignmentsStyling"


class StudentListView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      students: []
    };
};

componentDidMount() {  
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
      <AssignmentsContainer>
        <H2>Students</H2>
        <CardsContainer>
          {this.state.students.map(student => (
            <Card key={student[0]} style={{ width:"20%", margin:"2.5%", padding:"1.5%", paddingLeft:"3%", border: "1px solid #A9E8DC"}}>
              <NavLink to={`/studentAssignments/${student[0]}`} style={{textDecoration:"none", color:"black"}}>
                <CardTitle style={{paddingTop:"6px", fontWeight:"bold", textAlign:"center"}}>{student[1].firstName} {student[1].lastName}</CardTitle>
                <CardText >Experience: <span style={{fontWeight:"bold"}}>{student[1].level}</span></CardText>
                <CardText >Instrument: <span style={{fontWeight:"bold"}}>{student[1].instrument}</span></CardText>
                <CardText style={{paddingBottom:"12px", fontWeight:"bold", textAlign:"center"}}>{student[1].email}</CardText>
              </NavLink>
            </Card>
          ))}
        </CardsContainer>
      </AssignmentsContainer>
    );
  }
}

export default StudentListView;
