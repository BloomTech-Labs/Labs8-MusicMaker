// Assignment List: This page wil allow teacher's to see a list of all their ungraded assignments
 
import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';
// import { Route } from "react-router-dom";

// import * as routes from "../constants/routes";
// import StudentAssignmentsView from "./studentAssignmentsView";


class DashboardAssignmentsView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      assignments: []
    };
};

componentDidMount() {
  const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;

  axios
      .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/assignments`)
      .then(res => {
          console.log('Axios*******************', res.data)
          this.setState({assignments: res.data})
      })
      .catch(err => console.error('STUDENT LIST VIEW AXIOS:', err));
}

  render() {
    return (
      <div>
        <h1><Label>Assignments</Label></h1>
       
      </div>
    );
  }
}

export default DashboardAssignmentsView;