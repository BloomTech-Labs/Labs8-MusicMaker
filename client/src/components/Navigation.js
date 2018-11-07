import React from 'react';
import { Link } from 'react-router-dom';

import * as routes from '../constants/routes';

const Navigation = () => {
    return(
        <div>
            <Link to={ routes.SIGN_UP }>Sign Up</Link>
            <Link to={ routes.SIGN_IN }>Sign In</Link>
            <Link to={ routes.HOME }>Home</Link>
        </div>
    )
}

export default Navigation;