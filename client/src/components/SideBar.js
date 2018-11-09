import React from 'react';
import { NavLink } from 'react-router-dom';

const SideBar = () => {
    return(
        <div>
            <NavLink to="/assignments">Assignments</NavLink>
            <NavLink to="/billing">Biling</NavLink>
            <NavLink to="/settings">Settings</NavLink>
        </div>
    )
}

export default SideBar;