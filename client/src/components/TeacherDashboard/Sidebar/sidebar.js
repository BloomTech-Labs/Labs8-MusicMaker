import React from "react";
import { NavLink, Nav, Button } from "reactstrap";
import { FaUsers, FaFileSignature, FaCreditCard, FaCogs } from 'react-icons/fa';

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
      {/* <Button> */}
        <NavLink href="/students" style={SidebarStyling}><FaUsers />Students</NavLink>
      {/* </Button> */}
      {/* <Button> */}
        <NavLink href="/assignments" style={SidebarStyling}><FaFileSignature />Assignments</NavLink>
      {/* </Button> */}
      {/* <Button> */}
        <NavLink href="/billing" style={SidebarStyling}><FaCreditCard />Billing</NavLink>
      {/* </Button> */}
      {/* <Button> */}
        <NavLink href="/settings" style={SidebarStyling}><FaCogs />Settings</NavLink>
      {/* </Button> */}
    </Nav>
  );
};
export default SideBar;
