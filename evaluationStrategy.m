function evaluationStrategy(evaluation_name, strategies, do_plot, strategies_legend)
% evaluationStrategy - Plot effectiveness and efficiency for the given
% strategies.
%
%   Example:   evaluationStrategy('my-evaluation', {'my-strategy'}, true, {'My Strategy'})
%
%   evaluation_name: Name of the evaluation
%   strategies: Cell list of strategies
%   (do_plot): Optional set to true, if a plot should be created
%   (strategies_legend): Optional legend lables for the given strategies
%

    if nargin < 2
        error('Not enough input arguments.')
    elseif nargin < 3
        do_plot = false;
    end
    if nargin < 4
        strategies_legend = strategies;
    end
    
    evaluation_dir = getEvaluationDir(evaluation_name);
    

    fprintf('%s\t%s\t%s\t%s\n','effectiveness', 'efficiency', 'publications', 'strategy')
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
            %axis([0,50,0,1])
        figure(2)
            grid on
            legend(strategies_legend)
            %title('efficiency')
            xlabel('Messung')
            ylabel('Effizienz')
            %axis([0,50,0,0.18])
    end

end