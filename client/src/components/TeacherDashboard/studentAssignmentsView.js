//Student's Assignments View: This page will allow teacher's to see a specific student's list of all of their assignments.

import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardText, CardTitle, Button } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';
import * as routes from '../Routes/routes';

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

class StudentAssignmentsView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            assignments: [],
            students: []
        };
    };

    componentDidMount() {
        const studentId = this.props.match.params.studentId //'7HTc3cy6GGPWtjqfpgMB3ij3wY92';
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
        return(
            <div className = "container" style={formContainer}>
            <h1 style={{padding: "20px"}}><Label>Student's Assigments</Label></h1>
            <div style={{display:"flex", flexWrap:"wrap", flexDirection:"row"}}>
              {this.state.assignments.map(assignment => (
                <Card key={assignment[0]} style={{ width:"35%", margin:"1%", border: "1px solid #A9E8DC"}}>
                    <CardTitle>{assignment[1]}</CardTitle> {/* Assignment Name*/}
                    <CardText>Due Date: {assignment[2]}</CardText>
                    <CardText>Instrument: {assignment[3]}</CardText>
                    <CardText>Experience: {assignment[4]}</CardText>
                    <CardText>Piece: {assignment[5]}</CardText>
                    {/* <CardText>{assignment[6]}</CardText> */}
                    <CardText>Music Sheet: <a href={assignment[7]}><img src={assignment[7]} alt="pdf image" /></a></CardText>
                    <CardText>Video: <a href={assignment[8]}><img src={assignment[8]===null ? 'Not Completed': assignment[8]} alt={assignment[8]===null ? 'Not Completed': "video image"} /></a></CardText>
                    <CardText>Feedback: {assignment[9]===null ? "Not Graded" : assignment[9]}</CardText>
                    <CardText>Grade: {assignment[10]===null ? "Not Graded" : assignment[10]}</CardText>
                    <NavLink to={routes.GRADING}><Button>Grade Assignment</Button></NavLink>
                </Card>
              ))}
            </div>
          </div>
        )
    }

};



export default StudentAssignmentsView;
