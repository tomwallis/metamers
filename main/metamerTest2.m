%% METAMER DEMO (will take a few min per iteration)
%
% This version uses windows that tile the image in
% polar angle and log eccentricity, with parameters 
% used to generate metamers in Freeman & Simoncelli

% load original image
oim = double(imread('example-im-512x512.png'));

% set options
opts = metamerOpts(oim,'windowType=radial','scale=0.5','aspect=2');

% make windows
m = mkImMasks(opts);

% plot windows
plotWindows(m,opts);

% do metamer analysis on original (measure statistics)
params = metamerAnalysis(oim,m,opts);

% do metamer analysis with repositioned order of computation:
params2 = metamerAnalysis2(oim, m, opts); 

% check that params are the same:
[out, inds] = collectParams(params, opts);
[out2, inds] = collectParams(params2, opts);

all(all(out == out2))

%%% --> changing the starting angle doesn't affect the params. Can't be a
%%% problem at the analysis stage.

% % do metamer synthesis (generate new image matched for statistics)
% res = metamerSynthesis2(params,size(oim),m,opts);
