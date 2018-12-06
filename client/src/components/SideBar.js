import React from "react";
import { NavItem, NavLink, Nav } from "reactstrap";
import AuthUserContext from "./AuthUserContext";

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
    <Nav navbar className="border border-dark">
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
      <NavItem>
        <NavLink href="/grading">Grading</NavLink>
      </NavItem>
    </Nav>
  );
};
export default SideBar;
