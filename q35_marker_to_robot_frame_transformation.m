%{
Q3.5 Marker-to-Robot Frame Transformation: To complete the calibration process, we bring the robot
back to home position, once more acquire and MRI image of the markers, and compute the Frobmar frame
transformation, which will be constant for the rest of robot’s life. Your task is to compute the Frobmar
transformation. Input: M1, M2, M3, Frob(x,y,z,O). Output: Frobmar transformation. Test: Run the module
for the ideal ground truth robot, show that you got the result you expected. Hint: Implement and test what
you wrote for Q1. 
%}
function  F_rob_to_mar = q35_marker_to_robot_frame_transformation(M1, M2, M3, x_axis, y_axis, z_axis, O)
    % generate orthogonal frame from the markers on the robot
    [O_v, v1, v2, v3] = generate_orthonormal_frame(M1, M2, M3);
    
    % pass this frame into the transform function from A1 and transform it to home.
    F_mar_to_h = transform_frame_to_home(O_v, v1, v2, v3);
    % transform the robot frame to home
    F_rob_to_h = transform_frame_to_home(O, x_axis, y_axis, z_axis);
    F_h_to_rob = inv(F_rob_to_h);
    F_rob_to_mar = F_mar_to_h * F_h_to_rob;

end 
function [Oe, e1,e2,e3] = generate_orthonormal_frame(A, B, C)
    Oe = (A + B + C) / 3;
    e1 = (B - A) / norm(B - A);
    e2 = (C - A) - (dot((C - A), e1) * e1);  
    e2 = e2 / norm(e2);           
    e3 = cross(e1, e2);
    e3 = e3 / norm(e3);  
end
function T_v_to_h = transform_frame_to_home(O_v, v1, v2, v3)    
    % frame rotation to home
    R = [v1(:) v2(:) v3(:)];
    R = [R; 0,0,0];
    R = [R,[0;0;0;1]];
    % frame translation to home
    T = O_v(:);
    i=eye(4);
    i(1:3, 4) = T;
    T_v_to_h = i*R ; 
end