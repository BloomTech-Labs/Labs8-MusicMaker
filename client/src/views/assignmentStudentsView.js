//Assignment's Students List: After clicking on an assignment from dashboardAssigmentsView.js,
//it'll take you to another page with "+" to add student's to an assignment, 
//click assignment's name to see the full ungraded assignment,
//click on student to see student's assignment submission for grading.
import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Col, Row, Label, FormGroup, Input, DateTimeField } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';
// import { Route } from "react-router-dom";

import * as routes from "../constants/routes";
// import withPayment from '../components/withPayment';
// import GradeAssignmentView from "../views/gradeAssignmentView";

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

class StudentAssignmentsView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            students: [],
            modal:false,
            email: '',  
            dueDate:''          
        };
        this.toggle = this.toggle.bind(this);
    };

    toggle() {
        this.setState({
          modal: !this.state.modal
        });
    };

    onChange = event => {
        this.setState({
          [event.target.name]: event.target.value,
        });
      };

    onSubmit = event => {
        firebase.auth().onAuthStateChanged(user => {
            if (user) {
                // User is signed in.
                const assignmentId = this.props.match.params.assignmentId;
                const {email, dueDate} = this.state;

                console.log('params******************', user.uid, assignmentId)


                axios  
                    .post(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/assignment/${assignmentId}/assignToStudent`, {email, dueDate})
                    .then(res => {
                        console.log('Assign******************', res, assignmentId)
                    })
                    .catch(err => {
                        console.error('ASSIGN VIEW ERROR', err)
                    })
            } else {
                // No user is signed in.
                return;
              }
            });
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
        const assignmentId = this.props.match.params.assignmentId;

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
        const {email, dueDate} = this.state;
        return(
            <div style={formContainer}>
                <h1><Label>Student's Assigned to the Assignment</Label></h1>
                <Button onClick={this.toggle}>+</Button>
                <Modal isOpen={this.state.modal} toggle={this.toggle} className={this.props.className}>
                <ModalHeader toggle={this.toggle}>Assign Assignment to Student</ModalHeader>
                <ModalBody>
                    <Label for="exampleEmail">Email</Label>
                    <Input type="email" name="email" id="exampleEmail" placeholder="Student Email" value={email} onChange={this.onChange}  />
                    <Label for="exampleDate">Due Date</Label>
                    <Input type="date" name="dueDate" id="exampleDate" placeholder="mm/dd/yyyy" value={dueDate} onChange={this.onChange} />
                    {/* <Label for="exampleTime">Due Time</Label>
                    <Input type="time" name="dueDate" id="exampleTime" placeholder="hh:ss" value={dueDate} onChange={this.onChange} /> */}
                </ModalBody>
                <ModalFooter>
                    <Button color="primary"  onClick={this.onSubmit}>Submit</Button>
                    <Button color="secondary" onClick={this.toggle}>Cancel</Button>
                </ModalFooter>
                </Modal>
            <div>
                {this.state.students.map(student => (
                    <Row key={student[2]} style={{border:"1px solid black"}}>
                        <NavLink to={`/grading/${student[2]}/${student[0]}`} style={{textDecoration:"none"}} >
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