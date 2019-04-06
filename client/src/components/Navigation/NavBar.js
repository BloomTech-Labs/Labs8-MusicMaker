// Navigation Bar - What you see before login in.
import React from "react";
import { NavLink } from "reactstrap";

import * as routes from "../Routes/routes";
import AuthUserContext from "../Auth/AuthUserContext";
import SignOutButton from "../Auth/SignOutButton";
import mmmLogo from "../Images/mmmLogo.png";
import { NavBarContainer, Img, ButtonsContainer, Button } from "./NavBarStyle"

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
    <NavLink href={routes.DASHBOARD}><Img src={mmmLogo} /></NavLink>
    <SignOutButton />
  </NavBarContainer>
);

const NavigationNonAuth = () => (
  <NavBarContainer >
    <NavLink href={routes.LANDING}><Img src={mmmLogo} /></NavLink>

    <ButtonsContainer>
        <NavLink href={routes.SIGN_UP}><Button>Sign Up</Button></NavLink>
        <NavLink href={routes.SIGN_IN}><Button>Log In</Button></NavLink>
    </ButtonsContainer>
  </NavBarContainer>
);

export default Navigation;
