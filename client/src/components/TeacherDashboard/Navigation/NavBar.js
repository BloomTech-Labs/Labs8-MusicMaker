// Navigation Bar - What you see before login in.
import React from "react";
import { NavLink, Button } from "reactstrap";

import * as routes from "../../Routes/routes";
import AuthUserContext from "../../Auth/AuthUserContext";
import SignOutButton from "../../Auth/SignOutButton";
import mmmLogo from "../../Images/mmmLogo.png";
import { NavBarContainer, Logo, ButtonsContainer } from "./NavBarStyle"

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
  <NavBarContainer>
    <NavLink href={routes.DASHBOARD}><img src={mmmLogo} /></NavLink>
    <SignOutButton />
  </NavBarContainer>
);

const NavigationNonAuth = () => (
  <NavBarContainer >
    <Logo><NavLink href={routes.LANDING}><img src={mmmLogo} /></NavLink></Logo>
    <ButtonsContainer>
      <Button>
        <NavLink href={routes.SIGN_UP}>Sign Up</NavLink>
      </Button>
      <Button>
        <NavLink href={routes.SIGN_IN}>Log In</NavLink>
      </Button>
    </ButtonsContainer>
  </NavBarContainer>
);

export default Navigation;
