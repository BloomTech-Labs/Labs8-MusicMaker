import React from "react";
import { NavItem, NavLink, Nav } from "reactstrap";
import AuthUserContext from "../Auth/AuthUserContext";
import { Button } from 'reactstrap';

const sidebarContainer = { maxWidth: 800, height: 280, margin: '0 auto 10px', marginRight: "-30px", padding: "10px", border: "3px solid #A9E8DC" };

const SideBar = () => (
  <AuthUserContext.Consumer>
    {authUser => (authUser ? <SideBarAuth /> : <SidebarNonAuth />)}
  </AuthUserContext.Consumer>
);

const SidebarNonAuth = () => {
  return(
    <div></div>
  );
}

const SideBarAuth = () => {
  return (
    <Nav navbar className="border border-dark" style={sidebarContainer}>
      <Button outline color="info" size="sm" style={{display: "inline-block", marginTop: "20px", marginBottom: "10px"}}>
        <NavItem>
          <NavLink href="/students">Students</NavLink>
        </NavItem>
      </Button>
      <Button outline color="info" size="sm" style={{marginBottom: "10px"}}>
        <NavItem>
          <NavLink href="/assignments">Assignments</NavLink>
        </NavItem>
      </Button>
      <Button outline color="info" size="sm" style={{marginBottom: "10px"}}>
        <NavItem>
          <NavLink href="/billing">Billing</NavLink>
        </NavItem>
      </Button>
      <Button outline color="info" size="sm" style={{marginBottom: "10px"}}>
        <NavItem>
          <NavLink href="/settings">Settings</NavLink>
        </NavItem>
      </Button>
    </Nav>
  );
};
export default SideBar;
