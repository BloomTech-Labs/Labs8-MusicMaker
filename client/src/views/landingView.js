import React, { Component } from "react";

import jumbotron from '../less/imgs/landingView.png';
// import jumboLogo from "../less/imgs/jumboLogo.png"; <- working on resizing and/or editing this
import { Button, Card, CardBody, CardImg, CardSubtitle, CardText, CardTitle } from 'reactstrap';

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC"}

class LandingPageView extends Component {
  render() {
    return (
      <div className="landing" style={formContainer}>
        <CardImg src={jumbotron} width="100%" style={{ padding: "30px" }} />
        <Card>
          <CardBody>
            <CardTitle>Landing Page</CardTitle>
              <CardSubtitle>Placeholder</CardSubtitle>
                <CardText className="bodyText">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo
                  consequat nisl in ornare. Nulla quis fringilla ipsum, blandit luctus
                  purus. Phasellus suscipit enim massa, id molestie magna consectetur
                  ac. Praesent ut posuere tortor. Phasellus aliquam risus elit, commodo
                  accumsan arcu cursus et. Pellentesque ac pharetra eros, ut facilisis
                  arcu. Mauris hendrerit nibh mi, non fermentum quam pharetra non. Etiam
                  eu felis ac tortor accumsan finibus quis in odio. Suspendisse potenti.
                </CardText>
                <CardText className="bodyText">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo
                  consequat nisl in ornare. Nulla quis fringilla ipsum, blandit luctus
                  purus. Phasellus suscipit enim massa, id molestie magna consectetur
                  ac. Praesent ut posuere tortor. Phasellus aliquam risus elit, commodo
                  accumsan arcu cursus et. Pellentesque ac pharetra eros, ut facilisis
                  arcu. Mauris hendrerit nibh mi, non fermentum quam pharetra non. Etiam
                  eu felis ac tortor accumsan finibus quis in odio. Suspendisse potenti.
                </CardText>
              <Button outline color="info" size="lg" className="buyNow_Button"> Buy Now </Button>
          </CardBody>
        </Card>
      </div>
    );
  }
}

export default LandingPageView;
