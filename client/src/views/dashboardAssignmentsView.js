// Assignment List: This page wil allow teacher's to see a list of all their ungraded assignments
 
import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';

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
          this.setState({assignments: res.data})
      })
      .catch(err => console.error('ASSIGNMENTS LIST VIEW AXIOS:', err));
}

  render() {
    return (
      <div>
        <h1><Label>Assignments</Label></h1>
        <div style={{display:"flex", flexWrap:"wrap", flexDirection:"row"}}>
          {this.state.assignments.map(assignment => (
            <Card key={assignment[0]} style={{ width:"40%", margin:"1%"}}>
              <NavLink to={`/assignmentStudents/${assignment[0]}`} style={{textDecoration:"none", color:"black"}}>
                <CardTitle>{assignment[1].assignmentName}</CardTitle>
                <CardText>Experience: {assignment[1].level}</CardText>
                <CardText>Instrument: {assignment[1].instrument}</CardText>
                <CardText>Piece: {assignment[1].piece}</CardText>
                <CardText>Music Sheet: <a href={assignment[1].sheetMusic}><img src={assignment[1].sheetMusic} alt="pdf image" /></a></CardText>
                <CardText>Instructions: {assignment[1].instructions.substring(0,35)}...</CardText>

              </NavLink> 
            </Card>
          ))}
        </div>
      </div>
    );
  }
}

export default DashboardAssignmentsView;