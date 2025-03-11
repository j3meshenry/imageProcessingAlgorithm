%{
 
Class: CECS 271 
Student: James Henry 
Program: AddTwoNumbers.m
Goal: Create a program that takes any two inputs from the user
and does addition 
   
%}

while true

    % these are my user input variables that only take ints
    num1 = input('Enter first number: ');
    num2 = input('Enter second number: ');
        % Exit condition: if either num1 or num2 is 0, exit the loop
    if num1 == 0 || num2 == 0
        disp("Exiting the loop.");
        break; % Exit the loop
    end

    % adds the numbers
    sum = num1 + num2;
    
    % if the sum is larger than 10, display "Large Number"
    if sum > 10
        disp("LARGE NUMBER")
    end 
    
    % Display the sum
    disp(sum);

 end 
