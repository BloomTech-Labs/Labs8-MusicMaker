import React from "react";
import { NavLink } from "react-router-dom";

const SideBar = () => {
  return (
    <div className="sidebar">
      <NavLink to="/students" className="item">Students</NavLink>
      <NavLink to="/assignments" className="item">Assignments</NavLink>
      <NavLink to="/billing" className="item">Billing</NavLink>
      <NavLink to="/settings" className="item">Settings</NavLink>
      <NavLink to="/grading" className="item">Grading</NavLink>
    </div>
  );
};
export default SideBar;
