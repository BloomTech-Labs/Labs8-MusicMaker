import React from "react";
import { Navbar, NavbarBrand, NavLink, Nav } from "reactstrap";

import * as routes from "../constants/routes";

import AuthUserContext from "./AuthUserContext";
import SignOutButton from "../components/SignOutButton";

// import homeIcon from "../less/imgs/homeIcon.png";
import mmLogo from "../less/imgs/logo2.png";

const formContainer = { maxWidth: 800, margin: '0 auto 10px' };

const Navigation = () => (
  <AuthUserContext.Consumer>
    {authUser => (authUser ? <NavigationAuth /> : <NavigationNonAuth />)}
  </AuthUserContext.Consumer>
);

const NavigationAuth = () => (
  <Navbar style={formContainer}>
    <NavbarBrand href={routes.DASHBOARD}>
      <img src={mmLogo} />
    </NavbarBrand>
    <SignOutButton />
  </Navbar>
);

const NavigationNonAuth = () => (
  <Navbar style={formContainer}>
    <NavbarBrand href={routes.LANDING}>
      <img src={mmLogo} />
    </NavbarBrand>
    <Nav>
      <NavLink href={routes.SIGN_UP}>Sign Up</NavLink>
      <NavLink href={routes.SIGN_IN}>Sign In</NavLink>
    </Nav>
  </Navbar>
);

export default Navigation;
