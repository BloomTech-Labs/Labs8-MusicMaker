import React from 'react';
import { NavLink } from 'react-router-dom';
 const SideBar = () => {
    return(
        <div>
            <NavLink to="/students">Students</NavLink>
            <NavLink to="/assignments">Assignments</NavLink>
            <NavLink to="/billing">Billing</NavLink>
            <NavLink to="/settings">Settings</NavLink>
            <NavLink to="/qrcode">QR Code</NavLink>
        </div>
    )
}
 export default SideBar; 