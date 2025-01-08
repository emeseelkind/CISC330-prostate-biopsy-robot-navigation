%{
Q4.1 Inverse kinematics: To use the robot in surgery, we need to compute the values of translation,
rotation and needle insertion that will take the needle tip to this desired target point from the home position
of the device. Your task is to develop a method to compute the inverse kinematics. Use text, equations,
drawings to convey your approach. Implement this in software. Input: desired location of the needle tip.
Output: translation, rotation, insertion. Hint: Try to proceed backward from the previous. 
%}

function [translation, rotation, insertion] = q4_inverse_kin(target_point)
    % Extract target coordinates
    x_target = target_point(1);
    y_target = target_point(2);
    z_target = target_point(3);

    translation = [x_target; y_target; 0];
    % The angle is determined by the arc tangent of x/z coordinates
    rotation = atan2(y_target, x_target);
    
    % This is the straight-line distance from the rotated position to target
    insertion = z_target;
end
