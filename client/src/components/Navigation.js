import React from 'react';
import { Link } from 'react-router-dom';

import * as routes from '../constants/routes';
import SignOutButton from '../components/SignOutButton';

const Navigation = ({ authUser }) => 
    <div>
        { authUser 
            ? <NavigationAuth />
            : <NavigationNonAuth />
        }
    </div>

const NavigationAuth = () => 
    <div>
        <Link to={ routes.LANDING }>Landing Page</Link>
        <Link to={ routes.DASHBOARD }>Dashboard</Link>
        <SignOutButton />
    </div>

const NavigationNonAuth = () => 
    <div>
        <Link to={ routes.LANDING }>Landing Page</Link>
        <Link to={ routes.SIGN_UP }>Sign Up</Link>
        <Link to={ routes.SIGN_IN }>Sign In</Link>
    </div>

export default Navigation;