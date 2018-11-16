import { FETCHED_TEACHERS, FETCHING_TEACHERS, ERROR_FETCHING_TEACHERS } from '../actions';

const initialState = {
    teachers: [

    ],
    fetchedTeachers: false,
    fetchingTeachers: false,
}

export const rootReducer = (state = initialState, action) => {
    switch(action.type) {
    case FETCHED_TEACHERS:
    console.log("FETCHED_TEACHERS");
        return {
            ...state,
            fetchingTeachers: true,
        }
    case FETCHING_TEACHERS:
    console.log("FETCHING_TEACHERS");
        return {
            ...state,
            fetchedTeachers: true,
            fetchingTeachers: false,
        }
    case ERROR_FETCHING_TEACHERS:
    console.log("ERROR_FETCHING_TEACHERS");
        return {
            ...state,
            fetchedTeachers: false,
            fetchingTeachers: false,
        }
    
    default:
        return state;
    }
}