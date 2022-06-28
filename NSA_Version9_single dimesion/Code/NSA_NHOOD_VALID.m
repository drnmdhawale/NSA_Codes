% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com% Function to check if a choosen element has 8 immediate neighbours that
% are valid

%%
% Inputs is a Matrix: Zone(n X m)
% Output is a value of either 0 or < 0
% To call this funtion load the input data in workspace 
% (eg. load NSA_DATA1) and then type NHOOD_VALID = NSA_NHOOD_VALID(ZWINDOW)

%%
%sof

function NHOOD_VALID = NSA_NHOOD_VALID(ZWINDOW),

NHOOD_VALID=prod(ZWINDOW(:));
    
end
%%
%eof


