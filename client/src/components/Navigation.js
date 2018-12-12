import React from "react";
import { Navbar, NavbarBrand, NavLink, Nav } from "reactstrap";

import * as routes from "../constants/routes";

import AuthUserContext from "./AuthUserContext";
import SignOutButton from "../components/SignOutButton";

import mmLogo from "../less/imgs/logo2.png";
import { Button } from "reactstrap";

const formContainer = { maxWidth: 800, height: 90, margin: "0 auto 10px" };

const Navigation = () => (
  <AuthUserContext.Consumer>
    {authUser => 
    // {
    //   console.log('nav', authUser)
    // }
      
      (authUser 
        ? <NavigationAuth /> 
        : <NavigationNonAuth />)
    }
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
      <Button outline color="primary" size="sm" style={{ marginRight: "25px" }}>
        <NavLink href={routes.SIGN_UP}>Sign Up</NavLink>
      </Button>
      <Button color="primary" size="sm">
        <NavLink style={{ color: "#FFFFFF" }} href={routes.SIGN_IN}>
          Sign In
        </NavLink>
      </Button>
    </Nav>
  </Navbar>
);

export default Navigation;
