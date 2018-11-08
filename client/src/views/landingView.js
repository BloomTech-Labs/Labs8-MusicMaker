import React, { Component } from 'react';
// import { connect } from 'react-redux';

import ForgotPW from '../components/ForgotPW';

class LandingPageView extends Component {

    render() {
        return(
           <div>
               <h1>Landing Page</h1>
               <ForgotPW />
           </div> 
        ) 
    }
}

export default (LandingPageView);