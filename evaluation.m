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
        % moved
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