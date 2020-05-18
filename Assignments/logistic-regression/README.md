# Machine Learning: Logistic Regression

## Introduction
In this exercise, you will implement logistic regression and apply it to two different datasets. Before starting on the programming exercise, we strongly recommend watching the video lectures and completing the review questions for the associated topics.

To get started with the exercise, you will need to download the starter code and unzip its contents to the directory where you wish to complete the exercise. If needed, use the cd command in Octave/MATLAB to change to this directory before starting this exercise. You can also find instructions for installing Octave/MATLAB in the “En- vironment Setup Instructions” of the course website.

```
Files included in this exercise

ex2.m - Octave/MATLAB script that steps you through the exercise ex2 reg.m - Octave/MATLAB script for the later parts of the exercise ex2data1.txt - Training set for the first half of the exercise ex2data2.txt - Training set for the second half of the exercise submit.m - Submission script that sends your solutions to our servers mapFeature.m - Function to generate polynomial features plotDecisionBoundary.m - Function to plot classifier’s decision boundary

[⋆] plotData.m - Function to plot 2D classification data
[⋆] sigmoid.m - Sigmoid Function
[⋆] costFunction.m - Logistic Regression Cost Function
[⋆] predict.m - Logistic Regression Prediction Function
[⋆] costFunctionReg.m - Regularized Logistic Regression Cost

⋆ indicates files you will need to complete
```

Throughout the exercise, you will be using the scripts ex2.m and ex2 reg.m. These scripts set up the dataset for the problems and make calls to functions that you will write. You do not need to modify either of them. You are only required to modify functions in other files, by following the instructions in this assignment.


## 1.  Logistic Regression

In this part of the exercise, you will build a logistic regression model to predict whether a student gets admitted into a university. Suppose that you are the administrator of a university department and you want to determine each applicant’s chance of admission based on their results on two exams. You have historical data from previous applicants that you can use as a training set for logistic regression. For each training example, you have the applicant’s scores on two exams and the admissions decision. Your task is to build a classification model that estimates an applicant’s probability of admission based the scores from those two exams. This outline and the framework code in `ex2.m` will guide you through the exercise.

### 1.1  Visualizing the data

Before starting to implement any learning algorithm, it is always good to visualize the data if possible. In the first part of `ex2.m`, the code will load the data and display it on a 2-dimensional plot by calling the function plotData.

### 1.2  Sigmoid Function

Before you start with the actual cost function, recall that the logistic regression hypothesis is defined as:
`hθ(x) = g(θT x)`, where function g is the sigmoid function. The sigmoid function is defined as:
`1/1+e^−z`

Your first step is to implement this function in `sigmoid.m` so it can be called by the rest of your program. When you are finished, try testing a few values by calling sigmoid(x) at the Octave/MATLAB command line. For large positive values of x, the sigmoid should be close to 1, while for large negative values, the sigmoid should be close to 0. Evaluating sigmoid(0) should give you exactly 0.5. Your code should also work with vectors and matrices. For a matrix, your function should perform the sigmoid function on every element.


### 1.3  Cost Function and Gradient

Now you will implement the cost function and gradient for logistic regression. Complete the code in `costFunction.m` to return the cost and gradient.

Note that while this gradient looks identical to the linear regression gradient, the formula is actually different because linear and logistic regression have different definitions of hθ(x).
Once you are done, `ex2.m` will call your costFunction using the initial parameters of θ. 

```
You should see that the cost is about 0.693.
You should now submit your solutions.
```

### 1.4  Learning Parameters using `fminunc`

In the previous assignment, you found the optimal parameters of a linear re- gression model by implementing gradent descent. You wrote a cost function and calculated its gradient, then took a gradient descent step accordingly. This time, instead of taking gradient descent steps, you will use an Octave/- MATLAB built-in function called `fminunc`.

Octave/MATLAB’s fminunc is an optimization solver that finds the min- imum of an unconstrained function. For logistic regression, you want to optimize the cost function J(θ) with parameters θ. Concretely, you are going to use fminunc to find the best parameters θ for the logistic regression cost function, given a fixed dataset (of X and y values). You will pass to `fminunc` the following inputs:

```
• The initial values of the parameters we are trying to optimize.
• A function that, when given the training set and a particular θ, computes the logistic regression cost and gradient with respect to θ for the dataset (X, y)
```


### 1.5  Evaluating Logistic Regression

After learning the parameters, you can use the model to predict whether a particular student will be admitted. `For a student with an Exam 1 score of 45 and an Exam 2 score of 85, you should expect to see an admission probability of 0.776`.

Another way to evaluate the quality of the parameters we have found is to see how well the learned model predicts on our training set. In this part, your task is to complete the code in predict.m. The predict function will produce “1” or “0” predictions given a dataset and a learned parameter vector θ. After you have completed the code in predict.m, the ex2.m script will proceed to report the training accuracy of your classifier by computing the percentage of examples it got correct.

`You should now submit your solutions`.
 
## 2.  Regularized Logistic Regression

In this part of the exercise, you will implement regularized logistic regression to predict whether microchips from a fabrication plant passes quality assurance (QA). During QA, each microchip goes through various tests to ensure it is functioning correctly.

```
Suppose you are the product manager of the factory and you have the test results for some microchips on two different tests. From these two tests, you would like to determine whether the microchips should be accepted or rejected. To help you make the decision, you have a dataset of test results on past microchips, from which you can build a logistic regression model.

You will use another script, ex2 reg.m to complete this portion of the exercise.
```

### 2.1  Feature Mapping

One way to fit the data better is to create more features from each data point. In the provided function mapFeature.m, we will map the features into all polynomial terms of x1 and x2 up to the sixth power.

As a result of this mapping, our vector of two features (the scores on two QA tests) has been transformed into a 28-dimensional vector. A logistic regression classifier trained on this higher-dimension feature vector will have a more complex decision boundary and will appear nonlinear when drawn in our 2-dimensional plot.

While the feature mapping allows us to build a more expressive classifier, it also more susceptible to overfitting. In the next parts of the exercise, you will implement regularized logistic regression to fit the data and also see for yourself how regularization can help combat the `overfitting problem`.

### 2.2  Plotting the Decision Boundary

To help you visualize the model learned by this classifier, we have pro- vided the function plotDecisionBoundary.m which plots the (non-linear) decision boundary that separates the positive and negative examples. In plotDecisionBoundary.m, we plot the non-linear decision boundary by com- puting the classifier’s predictions on an evenly spaced grid and then and drew a contour plot of where the predictions change from y = 0 to y = 1.

### 2.3  Optional Exercise

In this part of the exercise, you will get to try out different regularization parameters for the dataset to understand how regularization prevents overfitting.

Notice the changes in the decision boundary as you vary λ. With a small λ, you should find that the classifier gets almost every training example correct, but draws a very complicated boundary, thus overfitting the data (Figure 5). This is not a good decision boundary: for example, it predicts that a point at x = (−0.25, 1.5) is accepted (y = 1), which seems to be an incorrect decision given the training set.

With a larger λ, you should see a plot that shows an simpler decision boundary which still separates the positives and negatives fairly well. How- ever, if λ is set to too high a value, you will not get a good fit and the decision boundary will not follow the data so well, thus underfitting the data 

By default, Octave/MATLAB interprets math operators to be matrix operators. This is a common source of size incompatibility errors. If you don’t want matrix multiplication, you need to add the “dot” notation to specify this to Octave/MATLAB. For example, AB does a matrix multiply, while A.B does an element-wise multiplication.

