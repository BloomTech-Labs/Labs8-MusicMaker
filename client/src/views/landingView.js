import React, { Component } from "react";

import jumbotron from '../less/imgs/landingView.png';

import { Button, Card, CardBody, CardImg, CardSubtitle, CardText, CardTitle } from 'reactstrap';

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC"}

class LandingPageView extends Component {
  render() {
    return (
      <div className="landing" style={formContainer}>
        <img src={jumbotron} width="100%" style={{ padding: "30px" }} />
        <Card>
          <CardBody>
            <h1 className="subheader">Landing Page</h1>
            <button className="buyNow_Button"> BUY NOW </button>
            <p className="bodyText">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo
              consequat nisl in ornare. Nulla quis fringilla ipsum, blandit luctus
              purus. Phasellus suscipit enim massa, id molestie magna consectetur
              ac. Praesent ut posuere tortor. Phasellus aliquam risus elit, commodo
              accumsan arcu cursus et. Pellentesque ac pharetra eros, ut facilisis
              arcu. Mauris hendrerit nibh mi, non fermentum quam pharetra non. Etiam
              eu felis ac tortor accumsan finibus quis in odio. Suspendisse potenti.
            </p>
            <p className="bodyText">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo
              consequat nisl in ornare. Nulla quis fringilla ipsum, blandit luctus
              purus. Phasellus suscipit enim massa, id molestie magna consectetur
              ac. Praesent ut posuere tortor. Phasellus aliquam risus elit, commodo
              accumsan arcu cursus et. Pellentesque ac pharetra eros, ut facilisis
              arcu. Mauris hendrerit nibh mi, non fermentum quam pharetra non. Etiam
              eu felis ac tortor accumsan finibus quis in odio. Suspendisse potenti.
            </p>
            <button className="buyNow_Button"> BUY NOW </button>
          </CardBody>
        </Card>
      </div>
    );
  }
}

export default LandingPageView;
