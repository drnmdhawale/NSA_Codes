% Function to check if a choosen element has atleast one immediate neighbour that
% of the present Zone

%%
% Date- December/11/13 % Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, % Department of Bioresource Engineering,
% McGill University, Macdonald Campus, % Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, % Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9. % email: nmdhawale@gmail.com

%%
% Inputs is the indice and a Matrix;nXm ;ZONE
% Output is a value of either 1(yes) or 0(no)
% To call this funtion load the input data in workspace 
% (eg. load NSA_DATA1) and then type NBR_VALID = NSA_NBR_VALID(IND, ZONE)

function NBR_VALID = NSA_NBR_VALID(IND, ZONE)

[rr cc]=size(ZONE); 
S=[rr,cc]; I=1;
%[row,col]=ind2sub(S,IND)

if (ZONE(IND-1)== max(ZONE(:))||ZONE(IND+1)== max(ZONE(:))|| ...
    ZONE(IND-rr)== max(ZONE(:))||ZONE(IND+rr)== max(ZONE(:))) %||...
    %ZONE((IND-rr)-1)== max(ZONE(:))||ZONE((IND-rr)+1)== max(ZONE(:))|| ...
    %ZONE((IND+rr)-1)== max(ZONE(:))||ZONE((IND+rr)+1)== max(ZONE(:))
   
NBR_VALID=1;

else
    NBR_VALID=0;
end