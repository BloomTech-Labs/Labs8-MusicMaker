//Student's Assignments View: This page will allow teacher's to see a specific student's list of all of their assignments.

import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';

class StudentAssignmentsView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            studentId: '',
            title: '',
            content: ''
        }
    }

}

export default StudentAssignmentsView;