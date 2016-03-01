clc
close all
%%
evaluation_name = 'test'


%% custom
%evaluation(evaluation_name, {'author-ordered-recursive+journal-ordered+conference-ordered', ...
%                             'author-ordered-recursive+journal-ordered-minyear+conference-ordered-minyear', ...
%                             'author-ordered-minyear-recursive+journal-ordered-minyear+conference-ordered-minyear+fieldofstudy-ordered-limit', ...
%                             'fieldofstudy-ordered-limit', ...
%                             'fieldofstudy-ordered'})
%evaluation(evaluation_name, {'author-ordered-minyear-recursive+journal-ordered-minyear', 'author-ordered-recursive+journal-ordered-minyear', 'journal', 'journal-ordered-minyear', 'author', 'author-ordered-recursive'})


%% basics
evaluation(evaluation_name, {'author', 'journal', 'conference'})


%% journals
evaluation(evaluation_name, {'journal', 'journal-ordered', 'journal-ordered-minyear'})


%% authors
evaluation(evaluation_name, {'author', 'author-ordered-recursive', 'author-ordered', 'author-ordered-minyear-recursive', 'author-ordered-minyear'})


%% conferences
evaluation(evaluation_name, {'conference', 'conference-ordered', 'conference-ordered-minyear'})


% fied of study
evaluation(evaluation_name, {'fieldofstudy', 'fieldofstudy-ordered', 'fieldofstudy-ordered-limit'})


%% all
evaluation(evaluation_name)

