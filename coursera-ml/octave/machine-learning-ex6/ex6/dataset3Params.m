function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and
%   sigma. You should complete this function to return the optimal C and
%   sigma based on a cross-validation set.
%

               % You need to return the following variables correctly.
  C = 1;
  sigma = 0.3;

        % ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example,
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using
%        mean(double(predictions ~= yval))
%

  vals = [0.01 0.03 0.1 0.3 1 3 10 30];

  best_error = inf;
  best_c = 0;
  best_sigma = 0;

  for i = 1:numel(vals)
    C_i = vals(i);

    for j = 1:numel(vals)
      sigma_j = vals(j);

      x1 = [1 2 1]; x2 = [0 4 -1];;
      model= svmTrain(X, y, C_i, @(x1, x2) gaussianKernel(x1, x2, sigma_j));

      predictions = svmPredict(model, Xval);

      errors = mean(double(predictions ~= yval));

      min_err = min(errors);

      if(min_err < best_error)
        best_error = min_err;
        best_c = C_i;
        best_sigma = sigma_j;
      end;

    end;
  end;

  C = best_c;
  sigma = best_sigma;

  fprintf('Best value C, sigma = [%f %f] with prediction error = %f\n', C, sigma, best_error);

% =========================================================================

end
