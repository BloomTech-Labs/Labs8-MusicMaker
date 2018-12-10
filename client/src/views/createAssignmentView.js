import React, { Component } from "react";
import { Input, Form, FormGroup, Label, Button } from 'reactstrap';
import axios from 'axios';

 class CreateAssignmentView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      assignmentName: "",
      instructions: "",
      instrument: "",
      level: "",
      piece: "",
      sheetMusic: null, loaded: 0
    };
  };

  onChange = event => {
    this.setState({
      sheetMusic: event.target.files[0],
      loaded: 0,
    })
  }

  handleUpload = () => {
    const data = new FormData()
    data.append('file', this.state.sheetMusic, this.state.sheetMusic.name)

    axios
      .post('http://localhost:8000/upload', data, {
        onUploadProgress: ProgressEvent => {
          this.setState({
            loaded: (ProgressEvent.loaded / ProgressEvent.total*100),
          })
        },
      })
      .then(res => {
        console.log(res.statusText)
      })

  }
  
  render() {
    return (
      <div className="container">
        <Form>
          <h2>Create a new assignment: </h2>
          <FormGroup>
            <Input type="text" name="assignment-name" placeholder="Assignment Name" />
           </FormGroup>
           <FormGroup inline style={{display: 'flex', justifyContent: 'space-around'}}>
             <Input type="text" name="piece" placeholder="Piece Name" />
 
             <Input type="select" name="instrument">
               <option value="instrument">Choose Instrument</option>
               <option value="drum">Drum</option>
               <option value="guitar">Guitar</option>
               <option value="piano">Piano</option>
               <option value="saxophone">Saxophone</option>
               <option value="trumpet">Trumpet</option>
               <option value="violin">Violin</option>
             </Input>
 
            <Input type="select" name="level">
              <option value="level">Choose Experience</option>
              <option value="beginner">Beginner</option>
              <option value="intermediate">Intermediate</option>
              <option value="expert">Expert</option>
            </Input>
          </FormGroup>
          <FormGroup>
            <Label>Instructions</Label>
              <Input type="textarea" name="instructions" placeholder="Instructions..." />
          </FormGroup>
          <FormGroup style={{display:'flex', alignItems:'center'}}>
            <Input type ='file' name='name' onChange={this.onChange} />
            <div style={{paddingRight:'64.5%'}}> {Math.round(this.state.loaded,2) }%</div>
          </FormGroup>
          <Button onClick={this.handleUpload}>Submit</Button>
        </Form>
      </div>
    );
  }
}

export default CreateAssignmentView;
