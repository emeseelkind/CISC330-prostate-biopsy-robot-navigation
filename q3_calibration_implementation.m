%{
Q3.3 Calibration Implementation: Implement the calibration sequences in software.
%}

function [x_axis, y_axis, z_axis, O, alpha] = q3_calibration_implementation()
    M1 = [-60; 0; -100];
    M2 = [0; 0; -100];
    M3 = [0; 0; -20];
    M4 = [-50; 0; 50];
    alpha = 45; %degrees

    stepsize = 5; %mm

    % translate M2 along z to find the z axis direction vector
    M2_2 = M2 + [0;0; stepsize];
    vector_M2 = M2_2 - M2;
    z_axis = vector_M2 / norm(vector_M2);
    
    % Generate rotation data points
    theta_steps = linspace(0,alpha,360);  % 30-degree steps
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
    M1_center = M1_center/norm(M1_center);
    M4_center = M4_center/norm(M4_center);
    %%%%%%%%%%%%%%%%%%%%%%%%how do you connect the center with the z axis
    
    % Generate needle insertion data points in one step
    needle_step = M4 + [-(cos(deg2rad(alpha))); 0; sin(deg2rad(alpha))];
    % Calculate needle direction vector from insertion points
    needle_dir = needle_step - M4;
    needle_dir = needle_dir / norm(needle_dir);
     
    % Since needle moves in XZ plane, y-axis is orthogonal to both z-axis and needle direction
    y_axis = cross(needle_dir, z_axis);
    y_axis = y_axis / norm(y_axis);
    
    % Calculate x-axis using cross product of y and z
    x_axis = cross(y_axis, z_axis);
    x_axis = x_axis / norm(x_axis);

    % Calculate alpha (needle exit angle)
    % the dot product returns a value between −1 and +1. The dot product measures how much one vector points in the same direction as the other
    alpha_angle = dot(needle_dir, z_axis);
    % convert decimal to radians from 0 to pi
    angle_in_rad = acos(alpha_angle);
    % convert radians to degrees from 0 to 180
    alpha = rad2deg(angle_in_rad);
    
    % Calculate origin O using intersection of z-axis with M1-M4 line
    v3 = cross(z_axis, needle_dir);
    v3 = v3 / norm(v3);
    v = [-needle_dir, z_axis, v3];
    p = M4 - [0;0;0];
    t = v \ p; 
    O = M4 + t(1) * needle_dir;
end
% 
% 
% function center = fit_circle_2d(points)
%     % Convert points to x and y coordinates
%     x = points(1,:);
%     y = points(2,:);
% 
%     % Centroid method
%     centroid_x = mean(x);
%     centroid_y = mean(y);
% 
%     % Least-squares circle fitting
%     A = [x' - centroid_x, y' - centroid_y];
%     b = -(x' - centroid_x).^2 - (y' - centroid_y).^2;    
%     sol = A \ b;
%     center_x = sol(1)/2 + centroid_x;
%     center_y = sol(2)/2 + centroid_y;
% 
%     center = [center_x; center_y; mean(points(3,:))];
% end