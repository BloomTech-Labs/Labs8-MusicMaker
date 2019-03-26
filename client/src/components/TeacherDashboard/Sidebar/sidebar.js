//Sidebar for when the user is logged in.
import React from "react";
import { NavLink } from "react-router-dom";
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

const SideBarAuth = () => {
  return (
    <Working>
      <NavLink to="/dashboard" ><Working><span><FaHome /></span>Home</Working></NavLink>
      <NavLink to="/students" ><Working><span><FaUsers /></span>Students</Working></NavLink>
      <NavLink to="/assignments" ><Working><span><FaFileSignature /></span>Assignments</Working></NavLink>
      <NavLink to="/billing" ><Working><span><FaCreditCard /></span>Billing</Working></NavLink>
      <NavLink to="/settings" ><Working><span><FaCogs /></span>Settings</Working></NavLink>
    </Working>
  );
};
export default SideBar;
