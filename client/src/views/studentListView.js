import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import { Label, Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import axios from 'axios';

class StudentListView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      students: []
    };
};

componentDidMount() {
  axios
      .get('https://musicmaker-4b2e8.firebaseapp.com/teacher/pwUGQC7SHBiPKPdnOq2c/students')
      .then(res => {
          this.setState({students: res.data})
      })
      .catch(err => console.error('STUDENT LIST VIEW AXIOS:', err));
}
  render() {
    return (
      <div>
        <h1><Label>Students</Label></h1>
        <div style={{display:"flex", flexWrap:"wrap", flexDirection:"row"}}>
          {this.state.students.map(student => (
            <Card key={student.id} style={{ width:"40%", margin:"1%"}}>
              <NavLink to={`/studentAssignments/${student.id}`} style={{textDecoration:"none", color:"black"}}>
                <CardTitle>{student.firstName} {student.lastName}</CardTitle>
                <CardText>{student.instrument}</CardText>
                <CardText>{student.level}</CardText>
                <CardText>{student.email}</CardText>
              </NavLink> 
            </Card>
          ))}
        </div>
      </div>
    );
  }
}

export default StudentListView;