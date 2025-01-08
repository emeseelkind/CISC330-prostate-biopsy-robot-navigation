%{
Q3.5 Marker-to-Robot Frame Transformation: test function
%}
function [] = test_q35()
    M1 = [-60; 0; -100];
    M2 = [0; 0; -100];
    M3 = [0; 0; -20];
    %M4 = [-50; 0; 50];
    % x_axis = [1; 0; 0];
    % y_axis = [0; 1; 0];
    % z_axis = [0; 0; 1];
    % O = [0; 0; 0];

    [x_axis, y_axis, z_axis, O, alpha] = q34_calibration_software_test();

    F_rob_to_mar = q35_marker_to_robot_frame_transformation(M1, M2, M3, x_axis, y_axis, z_axis, O);
    disp(F_rob_to_mar)

end