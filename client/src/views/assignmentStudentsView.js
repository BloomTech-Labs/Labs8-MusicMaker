//Assignment's Students List: After clicking on an assignment from dashboardAssigmentsView.js,
//it'll take you to another page with "+" to add student's to an assignment,
//click assignment's name to see the full ungraded assignment,
//click on student to see student's assignment submissiong.
import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Col, Row, Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';
// import { Route } from "react-router-dom";

// import * as routes from "../constants/routes";
// import withPayment from '../components/withPayment';
// import GradeAssignmentView from "../views/gradeAssignmentView";

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

class StudentAssignmentsView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            // assignments: [],
            students: [],
        };
    };

    // componentDidMount() {
    //     const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;
    //     const assignmentId = 'S1oOiT9EyHGUxwKDOJJI' //this.props.match.params.id;

    //     axios.all([
    //         axios.get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/assignment/${assignmentId}/students`),
    //         axios.get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/assignment/${assignmentId}`)
    //     ])
    //         .then(axios.spread (function (students, assignment){
    //             const studentsData = students.data || [];
    //             const assignmentData = assignment.data || [];
    //             // const assignmentStudents = assignmentData.concat(studentsData);
    //             console.log('students**********************', studentsData);
    //             console.log('assignment**********************', assignmentData.as);

    //             this.setState({
    //                 students: studentsData,
    //                 assignment: assignmentData
    //                 // assignmentStudents: assignmentStudents
    //             })
    //         }))
    //         .catch(err => console.error('ASSIGNMENT STUDENTS VIEW AXIOS ERROR:', err));
    // }

    componentDidMount() {
        const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;
        const assignmentId = 'S1oOiT9EyHGUxwKDOJJI' //this.props.match.params.id;

        firebase.auth().onAuthStateChanged(user => {
            if (user) {
              // User is signed in.
              axios
            .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/assignment/${assignmentId}/students`)
            .then(res => {
                console.log('student******************', res.data)
                this.setState({students:res.data})
            })
            .catch(err => console.error('ASSIGNMENT STUDENTS VIEW AXIOS ERROR:', err));
            } else {
              // No user is signed in.
              return;
            }
          });
    }

    render() {
        return(
            <div style={formContainer}>
                <h1><Label>Students Assigned to the Assignment</Label></h1>
                <h1>+</h1>
            <div>
                {this.state.students.map(student => (
                    <Row key={student[2]} style={{border:"1px solid black"}}>
                        <NavLink to={`grading/${student[2]}`} style={{textDecoration:"none"}} >
                            <Col>{student[3]} {student[4]}</Col> {/*student's name*/}
                        </NavLink>
                            <Col>{student[5]}</Col> {/*student's assignment due date*/}
                            <Col>{student[6]===null ? "" : "Student Completed"}</Col> {/*student's assignment completion status */}
                    </Row>
                ))}
            </div>
            {/* <Route exact path={routes.GRADING} component={withPayment(GradeAssignmentView)} /> */}
          </div>
        )
    }

};



export default StudentAssignmentsView;
