%{
Q3.4 Calibration Software Test: Your next task is to test the calibration software on the ideally
constructed “ground truth” robot. Your task is to simulate the appropriate motions with the ground truth
robot, generate simulated marker positions. You can translate the robot across the workspace in 5 mm
steps, rotate the robot in a 360 deg range in 30 deg increments, and insert/retract the needle across the
workspace in 5 mm increments. Run the calibration, and prove that you can reproduce the ground truth
Fro b(x, y, z, O, alpha) calibration parameters. 
%}


function [x_axis, y_axis, z_axis, O, alpha] = q34_calibration_software_test()
   
    M1 = [-60; 0; -100];
    M2 = [0; 0; -100];
    M3 = [0; 0; -20];
    M4 = [-50; 0; 50];
    alpha = 45; %degrees

    stepsize = 5; %mm

    % Find z axis by taking 2 points on the z axis (2 M2 points) and find the vector
    % Generate translation data points
    translation_steps = [0,5,10,15,20,25,30,35,40,45,50,55,60];  % 5mm insertion
    z_axes = zeros(3, length(translation_steps)); 
    
    % We will find z axis with M2 
    % so lets translate it -[0;0;30] so that we can find z with translation from 0 to 60 not -30 to 30
    M2_beginning = [0; 0; -100]-[0;0;30];

    for i = 1:length(translation_steps)
        stepsize = translation_steps(i);
        M2_2 = M2_beginning + [0; 0; stepsize];
        vector_M2 = M2_2 - M2_beginning;
        z_axes(:, i) = vector_M2 / norm(vector_M2);
    end
    % get the average of the axes
    z_axis = mean(z_axes(:, end),2);

    % Generate rotation data points
    theta_steps = [0,30,60,90,120,150,180,210,240,270,300,330,360];  % 30-degree steps
    M1_points = zeros(3, 12);
    M4_points = zeros(3, 12);
    
    for i = 1:12
        theta = theta_steps(i);
        % Rotate points around z-axis
        R = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
        M1_points(:,i) = R * M1;
        M4_points(:,i) = R * M4;
    end
    
    % Fit circles to M1 and M4 trajectories
    M1_center = mean(M1_points, 2);
    M4_center = mean(M4_points, 2);
    
    % Generate needle insertion data points
    insertion_steps = [5,10,15,20,25,30,35,40,45,50];  % 5mm insertion
    insertion_points = zeros(3, length(insertion_steps));
    
    for i = 1:length(insertion_steps)
        d = insertion_steps(i);
        insertion_points(:,i) = M4 + d * [-(cos(deg2rad(alpha))); 0; sin(deg2rad(alpha))];
    end
    
    % Calculate needle direction vector from insertion points
    needle_dir = insertion_points(:,end) - insertion_points(:,1);
    needle_dir = needle_dir / norm(needle_dir);
     
    % Since needle moves in XZ plane, y-axis is orthogonal to both z-axis and needle direction
    y_axis = cross(needle_dir, z_axis);
    y_axis = y_axis / norm(y_axis);
    
    % Calculate x-axis using cross product of y and z
    x_axis = cross(y_axis, z_axis);
    x_axis = x_axis / norm(x_axis);

    % Calculate alpha (needle exit angle)
    alpha = rad2deg(acos(dot(needle_dir, z_axis)));
    
    % Calculate origin O using intersection of z-axis with M1-M4 line
    v3 = cross(z_axis, needle_dir);
    v3 = v3 / norm(v3);
    v = [-needle_dir, z_axis, v3];
    p = M4 - [0;0;0];
    t = v \ p; 
    O = M4 + t(1) * needle_dir;
end
