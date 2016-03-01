function evaluation(name, strategies)

    if nargin < 2
        error('Not enough input arguments.')
    end
    
    evaluation_dir = fullfile('evaluation', name);
    if ~isdir(evaluation_dir)
       error('Evaluation files does not exists')
    end
 
    % '1': row offset to skip header liner
    %C '%u32 %u16 %u16'
    C = readLog(fullfile(evaluation_dir, 'authors.csv'), '%s %s %s', 1);
    authors_ids = C{1};
    authors_num_citations = C{2};
    authors_num_publications = C{2};    

    for i = 1:length(authors_ids)
        plot_strategies(evaluation_dir, authors_ids(i), authors_num_citations(i), strategies)
    end

end