//Student's Assignments View: This page will allow teacher's to see a specific student's list of all of their assignments.

import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';

class StudentAssignmentsView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            // studentId: '',
            // assignmentName: '',
            // dueDate: '',
            // instrument: '',
            // level: '',
            // piece: '',
            // instructions: '',
            // sheetMusic: '',
            // video: '',
            // feedback:'',
            // grade:'',
            assignments: []
        };
    };

    componentDidMount() {
        const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;
        const studentId = '7HTc3cy6GGPWtjqfpgMB3ij3wY92' //this.props.match.params.id;
        
        axios
            .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/student/${studentId}/assignments`)
            .then(res => {
                console.log('here**************************', res.data);
                this.setState({
                    assignments:res.data
                    // assignmentName: res.data.assignmentName,
                    // dueDate: res.data.dueDate,
                    // instrument: res.data.instrument,
                    // level: res.data.level,
                    // piece: res.data.piece,
                    // instructions: res.data.instructions,
                    // sheetMusic: res.data.sheetMusic,
                    // video: res.data.video,
                    // feedback:res.data.feedback,
                    // grade:res.data.grade
                })
            })
            .catch(err => console.error('STUDENTS ASSIGNMENTS VIEW AXIOS ERROR:', err));
    }

    render() {
        return(
            <div>
            <h1><Label>Student's Assigments</Label></h1>
            <div style={{display:"flex", flexWrap:"wrap", flexDirection:"row"}}>
              {this.state.assignments.map(assignment => (
                <Card key={assignment} style={{ width:"40%", margin:"1%"}}>
                    <CardTitle>{assignment}</CardTitle>
                    <CardText>{assignment}</CardText>
                    <CardText>{assignment}</CardText>
                    <CardText>{assignment}</CardText>
                </Card>
              ))}
            </div>
          </div>
        )
    }

};



export default StudentAssignmentsView;