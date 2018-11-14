import React, { Component } from "react";
// import { connect } from 'react-redux';

class LandingPageView extends Component {
  render() {
    return (
      <div>
        <h1>Landing Page</h1>
        <video id="videoPlayer" controls>
          <source src="http://localhost:8000/student/NKMNNypkVXUj4BSSyTPb/assigment/jKqbaQTm5lQikF6MMD9K/video" type="video/mp4"></source>
        </video>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo
          consequat nisl in ornare. Nulla quis fringilla ipsum, blandit luctus
          purus. Phasellus suscipit enim massa, id molestie magna consectetur
          ac. Praesent ut posuere tortor. Phasellus aliquam risus elit, commodo
          accumsan arcu cursus et. Pellentesque ac pharetra eros, ut facilisis
          arcu. Mauris hendrerit nibh mi, non fermentum quam pharetra non. Etiam
          eu felis ac tortor accumsan finibus quis in odio. Suspendisse potenti.
        </p>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo
          consequat nisl in ornare. Nulla quis fringilla ipsum, blandit luctus
          purus. Phasellus suscipit enim massa, id molestie magna consectetur
          ac. Praesent ut posuere tortor. Phasellus aliquam risus elit, commodo
          accumsan arcu cursus et. Pellentesque ac pharetra eros, ut facilisis
          arcu. Mauris hendrerit nibh mi, non fermentum quam pharetra non. Etiam
          eu felis ac tortor accumsan finibus quis in odio. Suspendisse potenti.
        </p>
      </div>
    );
  }
}

export default LandingPageView;
