import React from "react";
import { NavLink, Nav } from "reactstrap";
import { FaHome, FaUsers, FaFileSignature, FaCreditCard, FaCogs } from 'react-icons/fa';

import AuthUserContext from "../../Auth/AuthUserContext";


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

const SidebarStyling = {
  padding:".5rem 5rem", 
  color:"white",
  fontWeight:"bold",
};

const SideBarAuth = () => {
  return (
    <Nav>
      <NavLink href="/dashboard" style={SidebarStyling}><FaHome />Home</NavLink>
      <NavLink href="/students" style={SidebarStyling}><FaUsers />Students</NavLink>
      <NavLink href="/assignments" style={SidebarStyling}><FaFileSignature />Assignments</NavLink>
      <NavLink href="/billing" style={SidebarStyling}><FaCreditCard />Billing</NavLink>
      <NavLink href="/settings" style={SidebarStyling}><FaCogs />Settings</NavLink>
    </Nav>
  );
};
export default SideBar;
