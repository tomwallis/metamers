function [ norm_mse, prop_error, loss ] = metamerLoss(params_a, params_b, opts)
%Function to compute loss between two images given a model type from the
% Freeman and Simoncelli model.
%
% params_a assumed to come from original image. 
% 
% Two measures of loss: 
% norm_mse corresponds to what I think is reported in Freeman & Simoncelli
% as "mean squared error normalised by parameter variance":
% norm_mse = mean((a - b) .^2) ./ var(a)
%
% However, this value is in the scale of the squared params, which means
% it's not invariant to rescaling. Perhaps a better measure is in root mean
% square to be in the same units as the originals. We also normalise by the
% magnitude of the ground truth values, which is the relevant quantity if
% you're interested in numerical precision. Thanks to Alex Ecker for
% suggesting this.
%
% prop_error = sqrt(mean(loss .^ 2) ./ mean(a.^2));
%
% Finally I also return the loss (params_a - params_b) as loss.
% 
% Tom Wallis & Alex Ecker, 12/06/2017
%-----------------------------------------

a = unpack_params(params_a, opts);
b = unpack_params(params_b, opts);

% compute loss as "mean squared error normalised by parameter variance":
loss = (a - b);
norm_mse = mean(loss .^ 2) ./ var(a);
prop_error = sqrt(mean(loss .^ 2) ./ mean(a.^2));

    function v = unpack_params(params, opts)
       [out, inds] = collectParams(params, opts);
       v = [];
       field_names = fieldnames(inds);
       for i = 1 : length(fieldnames(inds))
          ind = inds.(field_names{i});
          tmp = out(ind, :);
          tmp = tmp(:);
          v = [v; tmp];
       end
    end
end
