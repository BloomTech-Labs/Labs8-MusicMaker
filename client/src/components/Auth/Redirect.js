import React from 'react';

import AuthUserContext from './AuthUserContext';

const Redirect = ({ history }) => (
  <AuthUserContext.Consumer>
    {authUser => (authUser ? history.push('/dashboard') : history.push('/signin'))}
  </AuthUserContext.Consumer>
);

export default Redirect;