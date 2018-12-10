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
      sheetMusic: '', loaded: 0
    };
  };

  onChange = event => {
    this.setState({
      [event.target.name]: event.target.value,
    })
  }

  uploadChange = event => {
    this.setState({
      sheetMusic: event.target.files[0], loaded: 0,
    })
  }

  onSubmit = event => {
    event.preventDefault();

    const { assignmentName, piece, instrument, level, instructions, sheetMusic } = this.state;

    let formData = new FormData();

    formData.append('assignmentName', assignmentName);
    formData.append('piece', piece);
    formData.append('instrument', instrument);
    formData.append('level', level);
    formData.append('instructions', instructions);
    formData.append('file', sheetMusic);

    axios
      // .post('http://localhost:8000/teacher/pwUGQC7SHBiPKPdnOq2c/createAssignment', 
      .post('https://musicmaker-4b2e8.firebaseapp.com/teacher/pwUGQC7SHBiPKPdnOq2c/createAssignment', 
        formData,
        {onUploadProgress: ProgressEvent => {
          this.setState({
            loaded: (ProgressEvent.loaded / ProgressEvent.total*100),
          })
        }}
      )
      .then(res => {
        console.log(res.statusText, res)
      })
}
  
  render() {
    const { assignmentName, piece, instructions } = this.state;
 
    return (
      <div className="container">
        <Form onSubmit={this.onSubmit}>
          <h2>Create a new assignment: </h2>
          <FormGroup>
            <Input type="text" name="assignmentName" placeholder="Assignment Name" value={assignmentName} onChange={this.onChange} />
           </FormGroup>
           <FormGroup inline style={{display: 'flex', justifyContent: 'space-around'}}>
             <Input type="text" name="piece" placeholder="Piece Name" value={piece} onChange={this.onChange} />
 
             <Input type="select" name="instrument" onChange={this.onChange}>
               <option value="instrument">Choose Instrument</option>
               <option value="drum">Drum</option>
               <option value="guitar">Guitar</option>
               <option value="piano">Piano</option>
               <option value="saxophone">Saxophone</option>
               <option value="trumpet">Trumpet</option>
               <option value="violin">Violin</option>
             </Input>
 
            <Input type="select" name="level" onChange={this.onChange}>
              <option value="level">Choose Experience</option>
              <option value="beginner">Beginner</option>
              <option value="intermediate">Intermediate</option>
              <option value="expert">Expert</option>
            </Input>
          </FormGroup>
          <FormGroup>
            <Label>Instructions</Label>
              <Input type="textarea" name="instructions" placeholder="Instructions..." value={instructions} onChange={this.onChange} />
          </FormGroup>
          <FormGroup style={{display:'flex', alignItems:'center'}}>
            <Input type ='file' name='sheetMusic' onChange={this.uploadChange} />
            <div style={{paddingRight:'64.5%'}}> {Math.round(this.state.loaded,2) }%</div>
          </FormGroup>
          <Button type="submit">Submit</Button>
        </Form>
      </div>
    );
  }
}

export default CreateAssignmentView;
