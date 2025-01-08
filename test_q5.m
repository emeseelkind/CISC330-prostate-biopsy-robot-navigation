%{
Test: Test your robot tracking solution on the ideally constructed “ground truth” robot.
• Case1: x [-60, -50, 0, 0], y [0,0,0,0], z [-100, -100, -20, 50]. This is a test case when the robot is
placed in the scanner such that Frob and FMRI are in coincidence.
• Case2: x [0, 50, 50, -10], y [50,50,50,50], z [-50, -50, 30, 100]. This is a test case when the robot
is placed in the scanner such that it was shifted by [50,50,50] in FMRI, with no rotation.
• Case3: x [-42, -35, 0, 0], y[ -35, 0, 0, 42], z[-100, -100, -20, 50]. This is a case when the robot is
placed in the scanner such that it is rotated by +45 degrees about +z in FMRI, with no translation.
For each test case, compute the expected marker positions and show that your marker tracking software
correctly produces the expected marker positions.
%}


function [] = test_q5()

    % case 1
    fprintf('Test Case 1: \n');

    [M1, M2, M3, M4] = q5_marker_tracking([-60, -50, 0, 0], [0,0,0,0], [-100, -100, -20, 50]);
    disp(['M1: ', num2str(M1)]);
    disp(['M2: ', num2str(M2)]);
    disp(['M3: ', num2str(M3)]);
    disp(['M4: ', num2str(M4)]);

    % case 2
    fprintf('Test Case 2: \n');
    [M1, M2, M3, M4] = q5_marker_tracking([0, 50, 50, -10], [50,50,50,50], [-50, -50, 30, 100]);
    disp(['M1: ', num2str(M1)]);
    disp(['M2: ', num2str(M2)]);
    disp(['M3: ', num2str(M3)]);
    disp(['M4: ', num2str(M4)]);
    % case 3
    fprintf('Test Case 3: \n');
    [M1, M2, M3, M4] = q5_marker_tracking([-42, -35, 0, 0], [-42, -35, 0, 0], [-100, -100, -20, 50]);
    disp(['M1: ', num2str(M1)]);
    disp(['M2: ', num2str(M2)]);
    disp(['M3: ', num2str(M3)]);
    disp(['M4: ', num2str(M4)]);
end

