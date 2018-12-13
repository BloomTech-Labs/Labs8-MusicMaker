import React from "react";
import { NavItem, NavLink, Nav } from "reactstrap";
import AuthUserContext from "./AuthUserContext";

const sidebarContainer = { maxWidth: 800, height: 200, margin: '0 auto 10px', padding: "10px", border: "3px solid #A9E8DC" };

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
      <NavItem>
        <NavLink href="/students">Students</NavLink>
      </NavItem>
      <NavItem>
        <NavLink href="/assignments">Assignments</NavLink>
      </NavItem>
      <NavItem>
        <NavLink href="/billing">Billing</NavLink>
      </NavItem>
      <NavItem>
        <NavLink href="/settings">Settings</NavLink>
      </NavItem>
    </Nav>
  );
};
export default SideBar;
