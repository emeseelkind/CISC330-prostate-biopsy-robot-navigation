%test all of q4

function [] = test_q4()
    disp('Q4.3 Kinematics Verification Tests:');
    
    % Generate 10 random target points within workspace
    N = 10;
    max_radius = 50;  % Maximum reach of the robot
    
    for i = 1:N
        % Generate random target within workspace
        r = rand() * max_radius;
        theta = (rand() * 2 - 1) * pi/2;  % Random angle ±90 degrees
        
        target = r * [sin(theta); 0; cos(theta)];
        
        % Compute inverse kinematics
        [trans, rot, ins] = q4_inverse_kin(target);
        
        % Compute forward kinematics with these outputs
        result = q4_forward_kin(trans, rot, ins);
        
        % Calculate error
        error = norm(target - result);
        
        % Display results
        disp("Target: ");
        disp(target);
        disp("Result: ");
        disp(result);
        disp("Error: ");
        disp(error);
    end
    
end