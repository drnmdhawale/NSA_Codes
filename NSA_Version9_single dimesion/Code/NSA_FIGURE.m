% Original start date: June/15/2011
% Modified Date- December/18/13, Nandkishor M. Dhawale/Viacheslav I. Adamchuk
% PhD. Candidate/Research Advisor, Department of Bioresource Engineering,
% McGill University, Macdonald Campus, Instrumentation and Control Lab
% MS1-063, 21111, Lakeshore Road, Ste-Anne-de-Bellevue,
% Quebec, Canada, H9X3V9.  email: nmdhawale@gmail.com
function NSA_FIGURE()

set(0,'Units','normalized');
get(0,'ScreenSize');
set(0,'Units','pixels') ;
scnsize = get(0,'ScreenSize');
fig1 = figure(1);
position = get(fig1,'Position');
outerpos = get(fig1,'OuterPosition');
borders = outerpos - position;
fig2 = figure(2); fig3 = figure(3); %fig4 = figure(4);
edge = borders(1)/2;
% pos1 = [edge,scnsize(4) * (1/2),scnsize(3)/2 - edge,scnsize(4)/2];
pos1 = [edge,0,scnsize(3)/2 - edge,scnsize(4)];
pos2 = [scnsize(3)/2 + edge,pos1(4)/2,pos1(3),pos1(4)/2-edge];
%pos3 = [edge,0,pos1(3),pos1(4)];
pos3 = [scnsize(3)/2 + edge,0, pos1(3),pos1(4)/2-edge];
    
set(fig1,'OuterPosition',pos1) 
set(fig2,'OuterPosition',pos2)
set(fig3,'OuterPosition',pos3) 
%set(fig4,'OuterPosition',pos4)
