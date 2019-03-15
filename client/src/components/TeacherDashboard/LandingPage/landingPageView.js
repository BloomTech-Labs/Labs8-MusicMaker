// Landing Page Content - What you see before login in.
import React, { Component } from "react";
import { Button, Card, CardBody, CardImg, CardSubtitle, CardText, CardTitle } from 'reactstrap';
import { Link } from 'react-router-dom';

import * as routes from '../../Routes/routes';
import landingView from '../../Images/landingView.png';
import { LandingContainer } from './landingPageStyle';


class LandingPageView extends Component {
  render() {
    return (
      <LandingContainer>
      
        {/* <CardImg src={landingView} width="100%" style={{ padding: "30px" }} /> */}
        <Card>
          <CardBody>
            <CardTitle style={{ marginBottom: "15px" }}>Music Master Maker</CardTitle>
              <CardSubtitle style={{ marginBottom: "15px" }}>Your one-stop portal for music educators and students.</CardSubtitle>
                <CardText className="bodyText">
                  Music Master Maker is an application for music teachers to remotely manage student practice sessions. Students sign 
                  up via a QR code unique to their teacher, then use their iOS device to record practice sessions and submit 
                  them for a teacher grade and feedback. 
                </CardText>
                {/* <CardText className="bodyText">
                  The student app has push notifications and emails a student when an assignment has been given and graded, and to 
                  teachers when an assignment has been submitted for grading.
                </CardText> */}
                <CardText className="bodyText">
                  The app is free for students and has a monthly fee for teachers.
                </CardText>
          </CardBody>
        </Card>
      </LandingContainer>
    );
  }
}

export default LandingPageView;
