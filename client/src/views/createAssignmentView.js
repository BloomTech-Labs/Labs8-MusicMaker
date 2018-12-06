import React, { Component } from "react";
import { Input, Form, FormGroup, Label, Button } from 'reactstrap';

class CreateAssignmentView extends Component {
  render() {
    return (
      <div>
        <div>
          <Form>
            <FormGroup>
              <Input 
                type="text"
                name="assignment-name"
                placeholder="Assignment Name"
              />
            </FormGroup>
            <FormGroup inline>
              <Input  type="text" name="piece" placeholder="Piece Name" />

              <Label>Instrument</Label>
              <Input type="select" name="instrument">
                <option value="guitar">Guitar</option>
                <option value="piano">Piano</option>
                <option value="trumpet">Trumpet</option>
                <option value="violin">Violin</option>
                <option value="saxophone">Saxophone</option>
                <option value="drum">Drum</option>
              </Input>

              <Label>Experience Level</Label>
              <Input type="select"  name="level">
                <option value="beginner">Beginner</option>
                <option value="intermediate">Intermediate</option>
                <option value="advanced">Advanced</option>
              </Input>
            </FormGroup>
            <FormGroup>
              <Label>Instructions</Label>
              <Input  type="textarea" name="instructions" placeholder="Instructions go here..." />
            </FormGroup>
            <Button className="submit">Submit</Button>
          </Form>
        </div>
      </div>
    );
  }
}

export default CreateAssignmentView;
