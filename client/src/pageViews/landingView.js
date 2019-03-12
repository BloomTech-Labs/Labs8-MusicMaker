import React, { Component } from "react";

import jumbotron from '../less/imgs/landingView.png';
// import jumboLogo from "../less/imgs/jumboLogo.png"; <- working on resizing and/or editing this
import { Button, Card, CardBody, CardImg, CardSubtitle, CardText, CardTitle } from 'reactstrap';
import { Link } from 'react-router-dom';
import * as routes from '../routes/routes';

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC"}

class LandingPageView extends Component {
  render() {
    return (
      <div className="landing" style={formContainer}>
        <CardImg src={jumbotron} width="100%" style={{ padding: "30px" }} />
        <Card>
          <CardBody>
            <CardTitle style={{ marginBottom: "15px" }}>Music Master Maker</CardTitle>
              <CardSubtitle style={{ marginBottom: "15px" }}>Your one-stop portal for music educators and students.</CardSubtitle>
                <CardText className="bodyText">
                  Music Master Maker is an application for music teachers to manage remote student practice sessions. Students sign 
                  up via a QR code unique to their teacher, then use their iOS device to record practice sessions and submit 
                  them to the teacher for feedback. 
                </CardText>
                <CardText className="bodyText">
                  The student app has push notifications and emails a student when an assignment has been given and graded, and to 
                  teachers when an assignment has been submitted for grading.
                </CardText>
                <CardText className="bodyText">
                  The app is free for students and has a monthly fee for teachers.
                </CardText>
                <Link to={routes.SIGN_UP}><Button outline color="info" size="lg">Sign Up For a Teacher Account Now!</Button></Link>
              {/* <Button outline color="info" size="lg">Sign Up For a Student Account Now!</Button> */}
          </CardBody>
        </Card>
      </div>
    );
  }
}

export default LandingPageView;
