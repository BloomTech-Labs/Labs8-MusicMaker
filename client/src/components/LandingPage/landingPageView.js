// Landing Page Content - What you see before login in.
import React, { Component } from "react";

import { LandingContainer, Header, Subtitle, Content, FinePrint } from './landingPageStyle';


class LandingPageView extends Component {
  render() {
    return (
      <LandingContainer>
          <Header>Music Master Maker</Header>
          <Subtitle>Your one-stop portal for music educators and students.</Subtitle>
          <Content >
            Music Master Maker is an application for music teachers to remotely manage student practice sessions. Students sign 
            up via a QR code unique to their teacher, then use their iOS device to record practice sessions and submit 
            them for a grade and feedback. 
          </Content>
          <FinePrint >The app is free for students and has a monthly fee for teachers.</FinePrint>
      </LandingContainer>
    );
  }
}

export default LandingPageView;
