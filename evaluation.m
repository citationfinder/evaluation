function evaluation(name, strategies, display_figure)

    if nargin < 2
        error('Not enough input arguments.')
    elseif nargin < 3
         display_figure = true;
    end
    
    evaluation_dir = fullfile('evaluation_data', name);
    if ~isdir(evaluation_dir)
       error('Evaluation files does not exists')
    end
    
 
    if display_figure
        % '1': row offset to skip header liner; '%u32 %u16 %u16'
        C = readLog(fullfile(evaluation_dir, 'authors.csv'), '%s %f %f', 1);
        authors_ids = C{1};
        authors_num_citations = C{2};
        authors_num_publications = C{3};
        
        fprintf('num_publications, mean=%f, min=%f, max=%f\n', mean(authors_num_publications), min(authors_num_publications), max(authors_num_publications))
        fprintf('num_citations, mean=%f, min=%f, max=%f\n', mean(authors_num_citations), min(authors_num_citations), max(authors_num_citations))

        for i = 1:length(authors_ids)
            plotStrategiesForAuthor(evaluation_dir, authors_ids{i}, strategies, authors_num_publications(i), authors_num_citations(i));
        end
    else
        
        fprintf('%s\t%s\t%s\n','effectiveness', 'efficiency', 'strategy')
        for i = 1:length(strategies)
            filename = fullfile(evaluation_dir, strcat('meta_', strategies{i}, '.csv'));
            
            % author_ids, author_num_citations, author_num_publications,
            % num_inspected_publications, num_citations
            C = readLog(filename, '%u32 %f %f %f %f', 1);
            plotStrategy(strategies{i}, C{2}, C{4}, C{5});
                
        end
        
        
        figure(1)
            grid on
            legend(strategies)
            title('effectiveness')
            xlabel('Measurement')
            ylabel('Effectiveness')
        figure(2)
            grid on
            legend(strategies)
            title('efficiency')
            xlabel('Measurement')
            ylabel('efficiency')
    end
end