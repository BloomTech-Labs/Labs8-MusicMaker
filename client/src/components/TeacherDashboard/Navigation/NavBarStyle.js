import styled from 'styled-components';


export const NavBarContainer = styled.div`
display: flex;
display-direction: row;
justify-content: space-between;
margin: 1.875rem 2.5rem;
`;

export const Img = styled.img`
height: 3.2rem;
width: 3.2rem;
border-radius: 2rem;
`;

export const ButtonsContainer = styled.div`
display: flex;
flex-direction: row;
`;

export const Button = styled.button`
color: white; 
font-weight: bold;
font-size: 1.25rem;
border: none;
background: none;
margin-top: 0.5rem;
cursor: pointer;

&:hover{
color: #02BEC4; 
}
`;

