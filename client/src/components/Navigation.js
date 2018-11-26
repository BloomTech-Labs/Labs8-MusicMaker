import React from "react";
import { Link } from "react-router-dom";

import * as routes from "../constants/routes";

import AuthUserContext from "./AuthUserContext";
import SignOutButton from "../components/SignOutButton";

import "../css/index.css";
import homeIcon from "../less/imgs/homeIcon.png";

const Navigation = ({ authUser }) => (
  <AuthUserContext.Consumer>
    {authUser => (authUser ? <NavigationAuth /> : <NavigationNonAuth />)}
  </AuthUserContext.Consumer>
);

const NavigationAuth = () => (
  <div className="nav">
    <div className="left">
      <Link to={routes.DASHBOARD}>
        <img className="item" src={homeIcon} />
      </Link>
    </div>
    <div className="right">
      <SignOutButton className="item" />
    </div>
  </div>
);

const NavigationNonAuth = () => (
  <div className="nav">
    <div className="left">
      <Link to={routes.LANDING}>
        <img className="item" src={homeIcon} />
      </Link>
    </div>
    <div className="right">
      <Link to={routes.SIGN_UP} className="item">
        Sign Up
      </Link>
      <Link to={routes.SIGN_IN} className="item">
        Sign In
      </Link>
    </div>
  </div>
);

export default Navigation;
