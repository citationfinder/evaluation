function evaluationPlotAuthors(evaluation_name, strategies, strategies_legend, specific_author_ids)

    if nargin < 2
        error('Not enough input arguments.')
    elseif nargin < 3
        strategies_legend = strategies;
    end
    if nargin < 4
         specific_author_ids = false;
    end
    
    evaluation_dir = getEvaluationDir(evaluation_name);
    
    % '1': row offset to skip header liner; '%u32 %u16 %u16'
    C = readLog(fullfile(evaluation_dir, 'authors.csv'), '%s %f %f', 1);
    authors_ids = C{1};
    authors_num_citations = C{2};
    authors_num_publications = C{3};
        
    fprintf('num_publications, mean=%f, min=%f, max=%f\n', mean(authors_num_publications), min(authors_num_publications), max(authors_num_publications))
    fprintf('num_citations, mean=%f, min=%f, max=%f\n', mean(authors_num_citations), min(authors_num_citations), max(authors_num_citations))

    for i = 1:length(authors_ids)
        %if exist('specific_author_ids', 'var') && ~any(specific_author_ids==str2double(authors_ids{i}))
        %    continue
        %end
        plotStrategiesForAuthor(evaluation_dir, authors_ids{i}, strategies, authors_num_publications(i), authors_num_citations(i), strategies_legend);
    end
end