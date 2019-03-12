// Navigation bar - What you see before login in.
import React from "react";
import { Navbar, NavbarBrand, NavLink, Nav, Button } from "reactstrap";

import * as routes from "../routes/routes";
import AuthUserContext from "./Auth/AuthUserContext";
import SignOutButton from "./Auth/SignOutButton";
import mmmLogo from "../styling/imgs/mmmLogo.png";

const formContainer = { maxWidth: 800, height: 90, margin: "0 auto 10px" };

const Navigation = () => (
  <AuthUserContext.Consumer>
    {authUser =>
      (authUser
        ? <NavigationAuth />
        : <NavigationNonAuth />)
    }
  </AuthUserContext.Consumer>
);

const NavigationAuth = () => (
  <Navbar style={{formContainer, paddingBottom: "40px"}}>
    <NavbarBrand href={routes.DASHBOARD} style={{position: "relative", left: "5%"}}>
      <img src={mmmLogo} />
    </NavbarBrand>
    <SignOutButton />
  </Navbar>
);

const NavigationNonAuth = () => (
  <Navbar style={formContainer}>
    <NavbarBrand href={routes.LANDING}>
      <img src={mmmLogo} />
    </NavbarBrand>
    <Nav>
      <Button outline color="primary" size="sm" style={{ marginRight: "25px" }}>
        <NavLink href={routes.SIGN_UP}>Sign Up</NavLink>
      </Button>
      <Button color="primary" size="sm">
        <NavLink style={{ color: "#FFFFFF"}} href={routes.SIGN_IN}>
          Log In
        </NavLink>
      </Button>
    </Nav>
  </Navbar>
);

export default Navigation;
