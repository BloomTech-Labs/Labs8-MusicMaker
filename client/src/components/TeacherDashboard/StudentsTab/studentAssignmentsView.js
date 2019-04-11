//Student's Assignments View: This page will allow teacher's to see a specific student's list of all of their assignments.

import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import {  Card, CardText, CardTitle, Button } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';

import { AssignmentsContainer, H2, CardsContainer }  from "../AssignmentsTab/ViewAllAssignmentsStyling"


class StudentAssignmentsView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            assignments: [],
            students: []
        };
    };

    componentDidMount() {
        const studentId = this.props.match.params.studentId;

          firebase.auth().onAuthStateChanged(user => {
            if (user) {
            //   User is signed in.
              axios
            .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/student/${studentId}/assignments`)
            .then(res => {
                this.setState({assignments: res.data})
            })
            .catch(err => console.error('STUDENTS ASSIGNMENTS VIEW AXIOS ERROR:', err));
            } else {
              // No user is signed in.
              return;
            }
          });
    }

    render() {
      const studentId = this.props.match.params.studentId;

        return(
            <AssignmentsContainer>
            <H2>Student's Assigments</H2>
            <CardsContainer>
              {this.state.assignments.map(assignment => (
                <Card key={assignment[0]}  style={{ width:"20%", margin:"2.5%", padding:"1.5%", border: "1px solid #A9E8DC"}}>
                    <CardTitle style={{paddingTop:"6px", fontWeight:"bold", textAlign:"center"}}>{assignment[1]}</CardTitle> {/* Assignment Name*/}
                    <CardText>Due Date: <span style={{fontWeight:"bold"}}>{assignment[2]}</span> </CardText>
                    <CardText>Experience: <span style={{fontWeight:"bold"}}>{assignment[4]}</span></CardText>
                    <CardText>Instrument: <span style={{fontWeight:"bold"}}>{assignment[3]}</span></CardText>
                    <CardText>Piece: <span style={{fontWeight:"bold"}}>{assignment[5]}</span></CardText>
                    <CardText>Music Sheet: <a style={{fontWeight:"bold"}} href={assignment[7]}><img src={assignment[7]} alt="Music Sheet" /></a></CardText>
                    <CardText>Video: <a  style={{fontWeight:"bold"}} href={assignment[8]}><img src={assignment[8]===null ? 'Not Completed': assignment[8]} alt={assignment[8]===null ? 'Not Completed': "Student's Recording"} /></a></CardText>
                    <CardText>Grade: <span style={{fontWeight:"bold"}}>{assignment[10]===null ? "Not Graded" : assignment[10]}</span></CardText>
                    <CardText>Feedback: {assignment[9]===null ? "Not Graded" : assignment[9]}</CardText>

                    <NavLink to={`/grading/${studentId}/${assignment[0]}`}><Button style={{width:"100%"}}>Grade Assignment</Button></NavLink>
                </Card>
              ))}
            </CardsContainer>
          </AssignmentsContainer>
        )
    }

};



export default StudentAssignmentsView;
