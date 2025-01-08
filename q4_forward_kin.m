%{
Q4.1 Forward kinematics: We need to be able to compute the resulting location of the needle tip upon
moving the motion stages (translation, rotation, insertion) of the robot from its home position. This is
called forward kinematics. Your task is to develop a develop a method to compute the forward
kinematics. Use text, equations, drawings to convey your approach. Implement this in software. Input:
translation, rotation, insertion. Output: location of the needle tip. Hint: execute a translation by ∆z, a
rotation by ∆ and an insertion by ∆i and see where those motions take the needle tip.
%}
function [needle_tip] = q4_forward_kin(translation, rotation, insertion)
    P0 = [0; 0; 0; 1];
    
    % Apply translation along z-axis
    T = eye(4);
    Tx = translation(1);
    Ty = translation(2);
    Tz = translation(3);
    T = [1 0 0 Tx; 0 1 0 Ty; 0 0 1 Tz; 0 0 0 1];
    
    % Rotation matrix about z-axis - homogeneous_rot_matrix
    R = [cosd(rotation), -sind(rotation), 0, 0; sind(rotation), cosd(rotation), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];
    
    % Calculate needle tip position after insertion
    % Note: The needle is inserted at 45 degrees (alpha) in the xz plane
    N = [1 0 0 0; 0 1 0 0; 0 0 1 insertion; 0 0 0 1];
    
    F = (T * R) * N;

    % final position of the needle tip
    needle_tip = F * P0;
    
    needle_tip = needle_tip(1:3);
end