%% 5.1 Basic strategies for two different types of authors
evaluationPlotAuthors('fire', {...
        'author', ...
        'journal', ...
        'conference' ...
    }, {...
        'Author strategy', ...
        'Journal strategy', ...
        'Conference strategy' ...
    }, [...
         1593916528, ...
         1843042359 ...
    ])
    
%% 5.2 Basic strategies
% Attention: You won't see these plots when execution the whole file since the
% other plots override the figures. Excute only this section.
evaluationStrategy('fire', {...
        'author', ...
        'journal', ...
        'conference' ...
    }, true, {...
        'Author strategy', ...
        'Journal strategy', ...
        'Conference strategy' ...
    })
    
%% 5.3 Compare optimizations for journal strategy
plotStrategiesForAuthor('fire', '1843042359', {...
        'journal', ...
        'journal-ordered', ...
        'journal-ordered-minyear'...
    }, 71, 1405, {...
        'Journal strategy', ...
        'Journal strategy (sorted)', ...
        'Journal strategy (sorted, min. year)'...
    })
    
%% 5.4, 5.5: Cluster authors and compare strategy for these clusters
evaluationClusterAuthors('fire', {...
        'author', ...
        'journal', ...
        'author-ordered-minyear-recursive+journal-ordered-minyear+conference-ordered-minyear'...
    })