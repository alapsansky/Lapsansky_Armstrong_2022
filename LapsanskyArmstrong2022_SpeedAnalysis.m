
% Lapsansky & Armstrong (2022) - Marine Ornithology


% A script for calculating the velocity achieved by four Common
% mergansers. Data are for two individuals that their wings + feet for
% submerged swimming and two that used their feet alone. The velocity is
% estimated in units of body-lengths based on the distance between the two 
% points digitized for each individual - the tip of the beak and the tip of 
% the tail. Thus, we assume that the animals swam perpendicular to the camera
% view and only digitized points during which this assumption appeared
% valid. Points were digitized using DLTdv8 (Hedrick 2008, Bioinspiration
% and Biomemetics) in MATLAB.  

% To view the digitized points and the identities of the digitized birds,
% one can use the DLTdv digitizing tool in MATLAB 
% (https://biomech.web.unc.edu/dltdv/). After installing the tool, the
% project can be loaded from the included file 
% (Lapsansky_Armstrong_2022_dvProject.mat) or by separately loading the video
% and points as a new project.



% Speed analysis ----------------------------------------------------------

% Import LapsanskyArmstrong2022_data_xypts.csv as a table using the 
% MATLAB "Import Data" button and rename the data as "A"


fps = 48; % the recording frequency of the videos

% Assign points to birds and remove the missing points (from before and
% after the bird was digitized)
w1 = rmmissing([A(:,1) A(:,2) A(:,3) A(:,4)]);
w2 = rmmissing([A(:,5) A(:,6) A(:,7) A(:,8)]);
f1 = rmmissing([A(:,9) A(:,10) A(:,11) A(:,12)]);
f2 = rmmissing([A(:,13) A(:,14) A(:,15) A(:,16)]);

% Calculate the body lengths for each animal as the distance between the
% tail and the beak using the pythagorean theorem
w1_length = sqrt((w1{:,1}-w1{:,3}).^2+(w1{:,2}-w1{:,4}).^2);
w1_length(end) = []; % remove last value so matrix is same size as velocity matrix
w2_length = sqrt((w2{:,1}-w2{:,3}).^2+(w2{:,2}-w2{:,4}).^2);
w2_length(end) = [];
f1_length = sqrt((f1{:,1}-f1{:,3}).^2+(f1{:,2}-f1{:,4}).^2);
f1_length(end) = [];
f2_length = sqrt((f2{:,1}-f2{:,3}).^2+(f2{:,2}-f2{:,4}).^2);
f2_length(end) = [];

% Prepare empty matrices for the velocity data
w1_vel = ones(4,(height(w1)-1))';
w2_vel = ones(4,(height(w2)-1))';
f1_vel = ones(4,(height(f1)-1))';
f2_vel = ones(4,(height(f2)-1))';

% For each individual, calculate the velocity in the x direction as the
% average velocity for the beak and tail points. Note that the velocities
% are multipled by (-1) just because the animals moved from right to left,
% which is the negative x direction in DLTdv8

for i=1:height(w1)-1
    w1_vel(i,1) = (w1{i+1,1}-w1{i,1})/(1/fps)*(-1); % beak velocity (px units)
    w1_vel(i,2) = (w1{i+1,3}-w1{i,3})/(1/fps)*(-1); % tail velocity (px units)
    w1_vel(i,3) = (w1_vel(i,1) + w1_vel(i,2))/2; % mean velocity (px units)
    w1_vel(i,4) = w1_vel(i,3)/w1_length(i); % velocity (body-length units)
end

for i=1:height(w2)-1
    w2_vel(i,1) = (w2{i+1,1}-w2{i,1})/(1/fps)*(-1);
    w2_vel(i,2) = (w2{i+1,3}-w2{i,3})/(1/fps)*(-1);
    w2_vel(i,3) = (w2_vel(i,1) + w2_vel(i,2))/2;
    w2_vel(i,4) = w2_vel(i,3)/w2_length(i);
end

for i=1:height(f1)-1
    f1_vel(i,1) = (f1{i+1,1}-f1{i,1})/(1/fps)*(-1);
    f1_vel(i,2) = (f1{i+1,3}-f1{i,3})/(1/fps)*(-1);
    f1_vel(i,3) = (f1_vel(i,1) + f1_vel(i,2))/2;
    f1_vel(i,4) = f1_vel(i,3)/f1_length(i);
end

for i=1:height(f2)-1
    f2_vel(i,1) = (f2{i+1,1}-f2{i,1})/(1/fps)*(-1);
    f2_vel(i,2) = (f2{i+1,3}-f2{i,3})/(1/fps)*(-1);
    f2_vel(i,3) = (f2_vel(i,1) + f2_vel(i,2))/2;
    f2_vel(i,4) = f2_vel(i,3)/f2_length(i);
end


% Finally, compute an average velocity for each individual
disp('Wing-propelled individual 1')
mean(w1_vel(:,4))
disp('Wing-propelled individual 2')
mean(w2_vel(:,4))
disp('Foot-propelled individual 1')
mean(f1_vel(:,4))
disp('Foot-propelled individual 2')
mean(f2_vel(:,4))

% If you have any questions or concerns, please email
% tony.lapsansky@gmail.com
