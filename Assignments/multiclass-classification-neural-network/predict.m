

function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

% Adding column of ones in X
X = [ones(m,1) X];
a_1 = X; % mxn

% Calculating z_2
z_2 = a_1*Theta1'; % Theta1 is hxn

% Calculating a_2
temp = sigmoid(z_2);
a_2 = [ones(m,1) temp]; % a_2 is mx(h+1)

% Calculating a_3
temp_1 = a_2*Theta2'; % Theta_2 is cx(h+1)
a_3 = sigmoid(temp_1); % a_3 is mxc 

% Calculating the max prediction and returning in form of a column vector of size mx1
[max_val t] = max(a_3,[],2); 
p = t';
% =========================================================================


end
