import React from "react";
import { Link } from "react-router-dom";

import * as routes from "../constants/routes";

import AuthUserContext from "./AuthUserContext";
import SignOutButton from "../components/SignOutButton";

import homeIcon from "../less/imgs/homeIcon.png";

const Navigation = () => (
  <AuthUserContext.Consumer>
    {authUser => (authUser ? <NavigationAuth /> : <NavigationNonAuth />)}
  </AuthUserContext.Consumer>
);

const NavigationAuth = () => (
  <div className="navbar">
    <div>
      <Link to={routes.DASHBOARD}>
        <img src={homeIcon} />
      </Link>
    </div>
    <div>
      <SignOutButton />
    </div>
  </div>
);

const NavigationNonAuth = () => (
  <div className="navbar">
    <div>
      <Link to={routes.LANDING}>
        <img src={homeIcon} />
      </Link>
    </div>
    <div>
      <Link to={routes.SIGN_UP}>
        Sign Up
      </Link>
      <Link to={routes.SIGN_IN}>
        Sign In
      </Link>
    </div>
  </div>
);

export default Navigation;
