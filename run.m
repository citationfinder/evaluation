close all
%%

authors = {'332714384', 'sven groppe', '67', '307';
           '110255', 'henry etzkowitz', '118', '';
           '358326', 'peter fratzl', '418', '';
           '63266', 'antonio p strafella', '46', ''};

%authors = {'332714384', 'sven groppe', '67', '307' }

%% all
for i=1:size(authors, 1)
    plot_strategies(authors{i,:})
end


%% journals
for i=1:size(authors, 1)
    plot_strategies(authors{i,:}, {'journal', 'journal-ordered', 'journal-ordered-minyear'})
end


%% authors
for i=1:size(authors, 1)
    plot_strategies(authors{i,:}, {'author', 'author-ordered-recursive', 'author-ordered'})
end


%% conferences
for i=1:size(authors, 1)
    plot_strategies(authors{i,:}, {'conference', 'conference-ordered'})
end


%% fied of study
for i=1:size(authors, 1)
    plot_strategies(authors{i,:}, {'fieldofstudy', 'fieldofstudy-ordered'})
end

