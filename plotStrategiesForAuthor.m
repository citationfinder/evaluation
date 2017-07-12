function plotStrategiesForAuthor(evaluation_name, author_id, strategies, author_num_publications, author_num_citations, strategies_legend)
% plotStrategiesForAuthor - Create plot for authors.
%
%   Example:   plotStrategiesForAuthor('my-evaluation', '15616', {'my-strategy'}, 10, 17, {'My Strategy'})
%
%   evaluation_name: Name of the evaluation
%   author_id: ID of the author
%   strategies: Cell list of strategies
%   (author_num_publications): Optional number of publications this author
%       has
%   (author_num_citations): Optional number of citations this author has
%   (strategies_legend): Optional legend lables for the given strategies
%

    if nargin < 3
        error('Not enough input arguments.')
    end
    if nargin < 4
        author_num_publications = '';
    end
    if nargin < 5
        author_num_citations = '';
    end
    if nargin < 6
        strategies_legend = strategies;
    end
    
    plot_linewidth = 2;
    plot_markersize = 15;
    evaluation_dir = getEvaluationDir(evaluation_name);
    
    figure
        hold on
        for i=1:length(strategies)
            filename = char(fullfile(evaluation_dir, strategies{i}, strcat(author_id, '.csv')));
            if exist(filename, 'file')
                %try
                data = csvread(filename);
                plot(data(:,1), data(:,2), '.-', 'linewidth', plot_linewidth, 'markersize', plot_markersize)
                %catch
                %    plot(0, 0, '.-')
                %end
            else
                plot(0, 0, '.-')
                %warning('File does not exists: %s', filename)
            end
        end
        hold off
        grid on
        %title(sprintf('Author %s (publications: %i, citations: %i)', author_id, author_num_publications, author_num_citations))
        xlabel('Publications examined')
        ylabel('Citations found')
        legend(strategies_legend, 'Location', 'southeast')
       
end