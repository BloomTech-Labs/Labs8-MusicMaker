import React from "react";
import { NavLink, Nav } from "reactstrap";
import { FaHome, FaUsers, FaFileSignature, FaCreditCard, FaCogs } from 'react-icons/fa';

import AuthUserContext from "../../Auth/AuthUserContext";
import { Working } from "./SidebarStyle";


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

// const SidebarStyling = {
//   padding:".5rem 35px", 
//   color:"white",
//   fontWeight:"bold",
//   // color:"#0284A8",
 

// };

const SideBarAuth = () => {
  return (
    <Nav>
      <Working>Hello</Working>
      <NavLink href="/dashboard" ><Working><FaHome />Home</Working></NavLink>
      <NavLink href="/students" ><FaUsers />Students</NavLink>
      <NavLink href="/assignments" ><FaFileSignature />Assignments</NavLink>
      <NavLink href="/billing" ><FaCreditCard />Billing</NavLink>
      <NavLink href="/settings" ><FaCogs />Settings</NavLink>
    </Nav>
  );
};
export default SideBar;
