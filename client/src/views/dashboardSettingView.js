import React, { Component } from 'react';
import axios from 'axios';

class Settings extends Component {
    constructor(props) {
        super(props);
        this.state = {
            email: "",
            name: {
                firstName: "",
                lastName: ""
            }
        };
    };
    

    componentDidMount() {
        axios
            .get('http://localhost:8000/teacher/AHnU7PuWMohJWEWZJbvd/settings')
            .then(res => {
                // console.log('*******************', Object.values(res.data)[0])
                this.setState({
                    email: Object.values(res.data)[0][0],
                    firstName: Object.values(res.data)[0][1],
                    lastName: Object.values(res.data)[0][2]
                })
            })
            .catch(err => console.error('Settings AXIOS ERROR:', err));
    }

    render() {
        return (
            <div>
                <h2>Testing that the Front End is Connecting to the Back End</h2>
                <h5>This is immutable, for now it only directs to the settings of a spefic teacher</h5>
                <p>Email: {this.state.email}</p>
                <p>First Name: {this.state.firstName}</p>
                <p>Last Name: {this.state.lastName}</p>
            </div>
        )
    }
}

export default Settings;
