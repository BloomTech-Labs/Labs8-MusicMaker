import React from "react";
import { NavItem, NavLink, Nav } from "reactstrap";

const SideBar = () => {
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
