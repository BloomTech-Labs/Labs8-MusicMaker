//Assignment's Students List: After clicking on an assignment from dashboardAssigmentsView.js,
//it'll take you to another page with "+" to add student's to an assignment, 
//click assignment's name to see the full ungraded assignment,
//click on student to see student's assignment submissiong.
import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Col, Row, Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';

class StudentAssignmentsView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            // assignmentId: '',
            assignmentName: '',
            students: [],
        };
    };

    componentDidMount() {
        const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;
        const assignmentId = 'S1oOiT9EyHGUxwKDOJJI' //this.props.match.params.id;
        

        axios
            .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/assignment/${assignmentId}/students`)
            .then(res => {
                console.log("Students************************", res.data)
                this.setState({
                    // assignmentId: res.data[0][0],
                    assignmentName: res.data[0].assignmentName,
                    students:res.data
                })
            })
            .catch(err => console.error('ASSIGNMENT STUDENTS VIEW AXIOS ERROR:', err));
    }

    render() {
        return(
            <div>
                <NavLink to={`/assignmentInfo/${this.state.assignmentId}`} >
                    <h1><Label>{this.state.assignmentName}</Label></h1>
                </NavLink> 
                <div>
                    {this.state.students.map(student => (
                        <Row key={student}>
                            <Col>{student}</Col>
                        </Row>
                    ))}
                </div>
          </div>
        )
    }

};



export default StudentAssignmentsView;
