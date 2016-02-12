function ep_res = run_ep_bt(count_data, count_times)
% ep_res = run_ep_bt(count_data, count_times)
% Description:
%    runs Expectation Propagation on the Poisson regression model, see ep_slopes_bt for details
% In:
%   count_data   -- data structure from the mutants project
%        count_data.rownames -- barcode names
%        count_data.y        -- tabular count data
%   count_times -- count times for the regression                 
% Out:
%    ep_res -- processed EP results
%    ep_res.rownames    -- see above
%    ep_res.y           -- see above
%    ep_res.count_times -- see above
%    ep_res.mp          -- prior means
%    ep_res.vp          -- prior variances
%    ep_res.options     -- EP options
%    ep_res.lam_mean    -- lambda means 
%    ep_res.lam_std     -- lambda variances 
%    ep_res.b_mean      -- b means
%    ep_res.b_std       -- b variances
%    ep_res.bt_mean     -- bt means
%    ep_res.bt_std      -- bt variances
%    ep_res.fit_mean    -- count fit mean
%    ep_res.fit_std     -- count fit standard deviation
%

ep_res.rownames    = count_data.rownames;
ep_res.y           = count_data.y;
ep_res.count_times = count_times;
ep_res.mp          = [  0   0    0   0*ones(1, size(count_data.y,2)-1)];
ep_res.vp          = [1e2 1e2 1e-4 1e2*ones(1, size(count_data.y,2)-1)];
ep_res.options     = infopt({'Verb',1, 'MaxIter', 1e2, 'eps', 0.9, 'TolX', 0.005});

% run ep
[m, v, V, proj, terms] = ep_slopes_bt(count_data.y, count_times, ep_res.mp, ep_res.vp, ep_res.options);

% keyboard;
nrows = size(count_data.y, 1);
ncols = size(count_data.y, 2);
ep_res.lam_mean = m(1:nrows);
ep_res.lam_std  = sqrt(v(1:nrows));
ep_res.b_mean   = m(nrows+1:2*nrows);
ep_res.b_std    = sqrt(v(nrows+1:2*nrows));
ep_res.bt_mean  = m(2*nrows+1:end);
ep_res.bt_std   = sqrt(v(2*nrows+1:end));
ep_res.fit_mean = exp(proj.m + 0.5*proj.v);
ep_res.fit_std  = ep_res.fit_mean.*sqrt(exp(proj.v)-1);

