
%{
main function for my code to run all the test functions
%}

function [] = main
    fprintf("-----------------------------------------------------\n");
    fprintf("Test for Question 3.3\n");
    [x_axis, y_axis, z_axis, O, alpha] = q3_calibration_implementation();
    fprintf("x_axis\n");
    disp(x_axis);
    fprintf("y_axis\n");
    disp(y_axis);
    fprintf("z_axis\n");
    disp(z_axis);
    fprintf("O\n");
    disp(O);
    fprintf("alpha\n");
    disp(alpha);
    fprintf("-----------------------------------------------------\n");
    
    fprintf("Test for Question 3.4\n");
    [x_axis, y_axis, z_axis, O, alpha] = q34_calibration_software_test();
    fprintf("x_axis\n");
    disp(x_axis);
    fprintf("y_axis\n");
    disp(y_axis);
    fprintf("z_axis\n");
    disp(z_axis);
    fprintf("O\n");
    disp(O);
    fprintf("alpha\n");
    disp(alpha);
    fprintf("-----------------------------------------------------\n");

    fprintf("Test for Question 3.5\n");
    test_q35;
    fprintf("\n-----------------------------------------------------\n");

    fprintf("Test for Question 4\n");
    test_q4;
    fprintf("\n-----------------------------------------------------\n");

    fprintf("Test for Question 5\n");
    test_q5;
    fprintf("\n-----------------------------------------------------\n");


end