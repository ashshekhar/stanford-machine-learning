# Machine Learning: Linear Regression

## Introduction
In this exercise, you will implement linear regression and get to see it work
on data. Before starting on this programming exercise, we strongly recommend watching the video lectures and completing the review questions for the associated topics.

```
Files included in this exercise

ex1.m- Octave/MATLAB script that steps you through the exercise
ex1multi.m- Octave/MATLAB script for the later parts of the exercise
ex1data1.txt- Dataset for linear regression with one variable
ex1data2.txt- Dataset for linear regression with multiple variables
submit.m- Submission script that sends your solutions to our servers

[?] warmUpExercise.m- Simple example function in Octave/MATLAB
[?] plotData.m- Function to display the dataset
[?] computeCost.m- Function to compute the cost of linear regression
[?] gradientDescent.m- Function to run gradient descent
[†] computeCostMulti.m- Cost function for multiple variables
[†] gradientDescentMulti.m- Gradient descent for multiple variables
[†] featureNormalize.m- Function to normalize features
[†] normalEqn.m- Function to compute the normal equations

?indicates files you will need to complete
†indicates optional exercises
```

Throughout the exercise, you will be using the scripts `ex1.mandex1multi.m`. These scripts set up the dataset for the problems and make calls to functions that you will write. You do not need to modify either of them. You are only required to modify functions in other files, by following the instructions in this assignment.

For this programming exercise, you are only required to complete the first part of the exercise to implement linear regression with one variable. The second part of the exercise, which is optional, covers linear regression with multiple variables.


## 1.  Simple Octave/MATLAB function
The first part of `ex1.m` gives you practice with Octave/MATLAB syntax and the homework submission process. In the `filewarmUpExercise.m`, you will find the outline of an Octave/MATLAB function. Modify it to return a 5 x 5 identity matrix by filling in the following code:

```
A = eye(5);
```


When you are finished, run `ex1.m`(assuming you are in the correct di- rectory, type “ex1” at the Octave/MATLAB prompt) and you should see output similar to the following:

```
ans =
Diagonal Matrix
1 0 0 0 0
0 1 0 0 0
0 0 1 0 0
0 0 0 1 0
0 0 0 0 1
````

Now `ex1.m` will pause until you press any key, and then will run the code for the next part of the assignment. If you wish to quit, typing ctrl-c will stop the program in the middle of its run.


## 2.  Linear regression with one variable
In this part of this exercise, you will implement linear regression with one variable to predict profits for a food truck. Suppose you are the CEO of a restaurant franchise and are considering different cities for opening a new outlet. The chain already has trucks in various cities and you have data for profits and populations from the cities.

You would like to use this data to help you select which city to expand to next.
The file `ex1data1.txt` contains the dataset for our linear regression problem. The first column is the population of a city and the second column is the profit of a food truck in that city. A negative value for profit indicates a loss.
The `ex1.m` script has already been set up to load this data for you.

#### Plotting the Data
Before starting on any task, it is often useful to understand the data by visualizing it. For this dataset, you can use a scatter plot to visualize the data, since it has only two properties to plot (profit and population).  In `ex1.m`, the dataset is loaded from the data file into the variables `X` and `y`

Next, the script calls the `plotData` function to create a scatter plot of the data. Your job is to complete `plotData.m` to draw the plot; modify the file and fill in the following code:

```
plot(x, y, 'rx', 'MarkerSize', 10); % Plot the data
ylabel('Profit in $10,000s'); % Set the y−axis label
xlabel('Population of City in 10,000s'); % Set the x−axis label
````

Now, when you continue to run `ex1.m`, our end result should look like Figure 1, with the same red “x” markers and axis labels. To learn more about the plot command, you can type `help plot` at the Octave/MATLAB command prompt or to search online for plotting documentation.


#### Gradient Descent
In this part, you will fit the linear regression parametersθ to our dataset using gradient descent.

##### Implementation

In `ex1.m`, we have already set up the data for linear regression. In the following lines, we add another dimension to our data to accommodate the θ0 intercept term. We also initialize the initial parameters to 0 and the learning rate alpha to 0.01.

```
X = [ones(m, 1), data(:,1)]; % Add a column of ones to x
theta = zeros(2, 1); % initialize fitting parameters

iterations = 1500;
alpha = 0.01;
```

##### Computing the cost J(θ)

As you perform gradient descent to learn minimize the cost functionJ(θ), it is helpful to monitor the convergence by computing the cost. In this section, you will implement a function to calculate J(θ) so you can check the convergence of your gradient descent implementation. Your next task is to complete the code in the file `computeCost.m`, which is a function that computes J(θ). As you are doing this, remember that the variables `Xandy` are not scalar values, but matrices whose rows represent the examples from the training set. Once you have completed the function, the next step in `ex1.m` will run `computeCost` once using θ initialized to zeros, and you will see the cost printed to the screen.

```
You should expect to see a cost of 32.07.
```

##### Gradient descent

Next, you will implement gradient descent in the file `gradientDescent.m`. The loop structure has been written for you, and you only need to supply the updates to θ within each iteration. As you program, make sure you understand what you are trying to optimize and what is being updated. Keep in mind that the cost J(θ) is parameterized by the vectorθ, notXandy. That is, we minimize the value ofJ(θ) by changing the values of the vectorθ, not by changing `X or y`. 

A good way to verify that gradient descent is working correctly is to look at the value ofJ(θ) and check that it is decreasing with each step. The starter code for `gradientDescent.m` calls `computeCost` on every iteration and prints the cost. Assuming you have implemented gradient descent and `computeCost` correctly, your value ofJ(θ) should never increase, and should converge to a steady value by the end of the algorithm. After you are finished, `ex1.m` will use your final parameters to plot the linear fit.  Your final values for θ will also be used to make predictions on profits in
areas of `35,000 and 70,000 people`. Note the way that the following lines in `ex1.m` uses matrix multiplication, rather than explicit summation or looping, to calculate the predictions. This is an example of code vectorization in Octave/MATLAB.

```
You should now submit your solutions.
predict1 = [1, 3.5]* theta;
predict2 = [1, 7]* theta;
```

#### Debugging
Here are some things to keep in mind as you implement gradient descent:

Octave/MATLAB array indices start from one, not zero. If you’re storingθ 0 andθ 1 in a vector called theta, the values will be theta(1)and theta(2).
If you are seeing many errors at runtime, inspect your matrix operations to make sure that you’re adding and multiplying matrices of compatible dimensions. Printing the dimensions of variables with thesize command will help you debug.

#### Training data

By default, Octave/MATLAB interprets math operators to be matrix operators. This is a common source of size incompatibility errors. If you don’t want matrix multiplication, you need to add the “dot” notation to specify this to Octave/MATLAB. For example, AB does a matrix multiply, while A.B does an element-wise multiplication.

#### Visualizing J(θ)
To understand the cost functionJ(θ) better, you will now plot the cost over a 2-dimensional grid of θ0 and θ1 values. You will not need to code anything new for this part, but you should understand how the code you have written already is creating these images. In the next step of `ex1.m`, there is code set up to calculateJ(θ) over a grid of values using thecomputeCostfunction that you wrote.

```
% initialize Jvals to a matrix of 0's
Jvals = zeros(length(theta0vals), length(theta1vals));

% Fill out Jvals

for i = 1:length(theta0vals)
 for j = 1:length(theta1vals)
  t = [theta0vals(i); theta1vals(j)];
  Jvals(i,j) = computeCost(x, y, t);
 end
end

```

After these lines are executed, you will have a 2-D array ofJ(θ) values. The script `ex1.m` will then use these values to produce surface and contour plots ofJ(θ) using the surf and contour commands.


If you have successfully completed the material above, congratulations! You now understand linear regression and should able to start using it on your own datasets.

For the rest of this programming exercise, we have included the following optional exercises. These exercises will help you gain a deeper understanding of the material, and if you are able to do so, we encourage you to complete them as well.

## 3.  Linear regression with multiple variables

In this part, you will implement linear regression with multiple variables to predict the prices of houses. Suppose you are selling your house and you want to know what a good market price would be. One way to do this is to first collect information on recent houses sold and make a model of housing prices.

The file `ex1data2.txt` contains a training set of housing prices in Portland, Oregon. The first column is the size of the house (in square feet), the second column is the number of bedrooms, and the third column is the price
of the house. The `ex1multi.m` script has been set up to help you step through this exercise.

#### Feature Normalization

The `ex1multi.m` script will start by loading and displaying some values
from this dataset. By looking at the values, note that house sizes are about
1000 times the number of bedrooms. When features differ by orders of magnitude, first performing feature scaling can make gradient descent converge much more quickly.

Your task here is to complete the code in `featureNormalize.m` Subtract the mean value of each feature from the dataset. After subtracting the mean, additionally scale (divide) the feature values by their respective “standard deviations.”

The standard deviation is a way of measuring how much variation there is in the range of values of a particular feature (most data points will lie within ±2 standard deviations of the mean); this is an alternative to taking the range of values (max min).

In Octave/MATLAB, you can use the “std” function to compute the standard deviation. For example, inside `featureNormalize.m`,
the quantity `X(:,1)`contains all the values of x1 (house sizes) in the training set, so `std(X(:,1))` computes the standard deviation of the house sizes.

At the time that `featureNormalize.m` is called, the extra column of 1’s corresponding to x0 = 1 has not yet been added to X(see `ex1multi.m` for details).

You will do this for all the features and your code should work with
datasets of all sizes (any number of features / examples). Note that each
column of the matrixXcorresponds to one feature.

#### Implementation Note 
When normalizing the features, it is important to store the values used for normalization - the mean value and the standard deviation used for the computations. After learning the parameters from the model, we often want to predict the prices of houses we have not seen before. 

Given a new `xvalue` (living room area and number of bedrooms), we must first normalize x using the mean and standard deviation that we had previously computed from the training set.

#### Gradient Descent
Previously, you implemented gradient descent on a univariate regressio problem. The only difference now is that there is one more feature in the matrix X. The hypothesis function and the batch gradient descent update rule remain unchanged.

You should complete the code in `computeCostMulti.m` and `gradientDescentMulti.m` to implement the cost function and gradient descent for linear regression with multiple variables. If your code in the previous part (single variable) already supports multiple variables, you can use it here too.

Make sure your code supports any number of features and is well-vectorized.
You can use `‘size(X, 2)’` to find out how many features are present in the
dataset.


In this part of the exercise, you will get to try out different learning rates for the dataset and find a learning rate that converges quickly. You can change the learning rate by modifying `ex1multi.m` and changing the part of the
code that sets the learning rate.

The next phase in `ex1multi.m` will call your `gradientDescent.m` function and run gradient descent for about 50 iterations at the chosen learning rate. The function should also return the history ofJ(θ) values in a vector J. After the last iteration, the `ex1multi.m` script plots the J values against the number of the iterations.


#### Convergence of gradient descent with an appropriate learning rate

If your learning rate is too large,J(θ) can diverge and ‘blow up’, resulting in values which are too large for computer
calculations. In these situations, Octave/MATLAB will tend to return NaNs. NaN stands for ‘not a number’ and is often caused by undefined operations that involve −∞ and +∞. Octave/MATLAB Tip: To compare how different learning learning rates affect convergence, it’s helpful to plotJfor several learning rates on the same figure. In Octave/MATLAB, this can be done by performing gradient descent multiple times with a `hold on`command between plots. 

Notice the changes in the convergence curves as the learning rate changes. With a small learning rate, you should find that gradient descent takes a very long time to converge to the optimal value. Conversely, with a large learning rate, gradient descent might not converge or might even diverge! Using the best learning rate that you found, run theex1multi.mscript to run gradient descent until convergence to find the final values ofθ. Next, use this value ofθto predict the price of a house with `1650 square feet and 3 bedrooms`. You will use value later to check your implementation of the normal equations. Don’t forget to normalize your features when you make this prediction!

#### Normal Equations

Using this formula does not require any feature scaling, and you will get an exact solution in one calculation: there is no “loop until convergence” like in gradient descent.

Complete the code in `normalEqn.m` to use the formula above to calculate θ. Remember that while you don’t need to scale your features, we still need to add a column of 1’s to the X matrix to have an intercept term (θ0).


