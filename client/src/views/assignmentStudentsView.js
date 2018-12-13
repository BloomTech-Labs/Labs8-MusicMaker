//Assignment's Students List: After clicking on an assignment from dashboardAssigmentsView.js,
//it'll take you to another page with "+" to add student's to an assignment, 
//click assignment's name to see the full ungraded assignment,
//click on student to see student's assignment submission for grading.
import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Col, Row, Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle } from 'reactstrap';
import axios from 'axios';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';
// import { Route } from "react-router-dom";

// import * as routes from "../constants/routes";
// import withPayment from '../components/withPayment';
// import GradeAssignmentView from "../views/gradeAssignmentView";


class StudentAssignmentsView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            // assignments: [],
            students: [],
            modal:false
        };

        this.toggle = this.toggle.bind(this);
    };

    toggle() {
        this.setState({
          modal: !this.state.modal
        });
      }

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
        

        axios
            .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/assignment/${assignmentId}/students`)
            .then(res => {
                console.log('student******************', res.data)
                this.setState({students:res.data})
            })
            .catch(err => console.error('ASSIGNMENT STUDENTS VIEW AXIOS ERROR:', err));
    }

    render() {
        return(
            <div>
                <h1><Label>Student's Assigned to the Assignment</Label></h1>
                <Button onClick={this.toggle}>+</Button>
                <Modal isOpen={this.state.modal} toggle={this.toggle} className={this.props.className}>
                <ModalHeader toggle={this.toggle}>Assign Assignment to Student</ModalHeader>
                <ModalBody>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={this.toggle}>Do Something</Button>{' '}
                    <Button color="secondary" onClick={this.toggle}>Cancel</Button>
                </ModalFooter>
                </Modal>
            <div>
                {this.state.students.map(student => (
                    <Row key={student[2]} style={{border:"1px solid black"}}>
                        <NavLink to={`/grading/${student[2]}`} style={{textDecoration:"none"}} >
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
