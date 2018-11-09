import React, { Component } from "react";
// import { connect } from 'react-redux';

import Navigation from '../components/Navigation.js';

class LandingPageView extends Component {
  render() {
    return (
      <div>
        <Navigation />
        
        <h1>Landing Page</h1>
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
        <button> BUY NOW </button>
      </div>
    );
  }
}

export default LandingPageView;
