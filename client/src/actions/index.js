import axios from 'axios';

export const FETCHED_TEACHERS = "FETCHED_TEACHERS";
export const FETCHING_TEACHERS = "FETCHING_TEACHERS";
export const ERROR_FETCHING_TEACHERS = "ERROR_FETCHING_TEACHERS";

export const fetchTeachers = () => {
    return dispatch => {
      dispatch({ type: FETCHING_TEACHERS });
  
      axios
        .get('http://localhost:8000/teachers')
        .then(response => {
          dispatch({
            type: FETCHED_TEACHERS,
            payload: response.data
          });
        })
        .catch(() => {
          dispatch({
            type: ERROR_FETCHING_TEACHERS,
            payload: "ERROR: unable to fetch Teachers"
          });
        })
    }
  }