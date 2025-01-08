%{
Your task is to develop a method and software to reconstruct the 4 markers used in the “ground truth”
robot from their gradient locations. Note that the M4 marker in the needle tip is not fixed with respect to
other markers, it moves during the calibration process. Explain your approach in comments or on paper,
as you prefer.
Input: x [x1, x2, x3, x4], y [y1, y2, y3, y4], z [z1, z2, z3, z4] for the x, y, z gradient locations where markers
were detected in the MRI signal.
Output: M1, M2, M3, M4 marker positions
%}

function [M1, M2, M3, M4]  = q5_marker_tracking(x, y, z)
    M1_ground_t = [-60; 0; -100];
    M2_ground_t = [0; 0; -100];
    M3_ground_t = [0; 0; -20];
    M4_ground_t = [-50; 0; 50];
    % Distance from M2 to M3 in z gradient
    dist_on_z = M3_ground_t(3) - M2_ground_t(3);

    M1 = zeros(1,3);
    M2 = zeros(1,3);
    M3 = zeros(1,3);
    M4 = zeros(1,3);

    % Find z-coordinates for M1 and M2 (same z-coordinate)
    for i = (1:length(z))
        for j = (1:length(z))
            % Assign matching z to M1 and M2
            if (z(i) == z(j)) && (i~=j)
                M1(3) = z(i);
                M2(3) = z(j);
                
            end
            % Assign the z that is 80 away from M1 and M2 to M4
            if abs(z(i) - z(j)) == dist_on_z
                M3(3) = z(i);
            end

        end
    end
    % remove these points from z
    z = setdiff(z, [M1(3), M2(3), M3(3)]);

    % Assign the last z value to M4
    M4(3) = z(end);    

    % Find x and y coordinates for M2 and M3 (same x and y)
    for i = (1:length(x))
        for j = (1:length(x))
            if (x(i) == x(j)) && (i~=j)
                M2(1) = x(i);
                M3(1) = x(j);
                M2(2) = y(i);
                M3(2) = y(j);
            end
        end
    end
    % delete the used x values
    x(x == M2(1)) = [];
    x(x == M3(1)) = [];

    % delete the used y values
    if all(y == y(1))
        y(1:2) = [];
    else
        unique_vals = unique(y);
        for i = 1:length(unique_vals)
            if sum(y == unique_vals(i)) >= 2
                y(y == unique_vals(i)) = [];
            end
        end
         
    end 
    
    min_error = 100;
    for i = 1:2
        for j = 1:2
            %euclidean distance to find M1(1)=-60 and m4(1)=-50
            curr = [x(i), y(j), M1(3)] ;
            distance2 = norm(curr - M2);
            distance3 = norm(curr - M3);
            error2 = abs(distance2 - 60);
            error3 = abs(distance3 - 100);
            error = error2 + error3;
            
            % Update M1 if current point has lower error
            if error < min_error
                min_error = error;
                M1(1) = x(i);
                M1(2) = y(j);
            end
        end
    end
    x(x == M1(1)) = [];
    M4(1) = x(end);
    M4(2) = y(end);
    
end
