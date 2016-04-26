function evaluationStrategy(evaluation_name, strategies, do_plot, strategies_legend)

    if nargin < 2
        error('Not enough input arguments.')
    elseif nargin < 3
        do_plot = false;
    end
    if nargin < 4
        strategies_legend = strategies;
    end
    
    evaluation_dir = getEvaluationDir(evaluation_name);
    

    fprintf('%s\t%s\t%s\n','effectiveness', 'efficiency', 'strategy')
    for i = 1:length(strategies)
        filename = fullfile(evaluation_dir, strcat('meta_', strategies{i}, '.csv'));
        
        % author_ids, author_num_citations, author_num_publications,
        % num_inspected_publications, num_citations
        C = readLog(filename, '%u32 %f %f %f %f', 1);
        plotStrategy(strategies{i}, C{2}, C{4}, C{5}, do_plot);         
    end

    if do_plot
        figure(1)
            grid on
            legend(strategies_legend)
            %title('effectiveness')
            xlabel('Messung')
            ylabel('Effektivität')
        figure(2)
            grid on
            legend(strategies_legend)
            %title('efficiency')
            xlabel('Messung')
            ylabel('Effizienz')
    end

end