function plot_strategies(evaluation_dir, author_id, strategies, author_num_publications, author_num_citations, strategies_legend)

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
    
    figure
        hold on
        for i=1:length(strategies)
            filename = char(fullfile(evaluation_dir, strategies{i}, strcat(author_id, '.csv')));
            if exist(filename, 'file')
                %try
                data = csvread(filename, 1);
                plot(data(:,1), data(:,2), '.-')
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
        title(sprintf('Autor %s (Publikationen: %i, Zitate: %i)', author_id, author_num_publications, author_num_citations))
        xlabel('Untersuchte Publikationen')
        ylabel('Gefundene Zitate')
        legend(strategies_legend, 'Location', 'southeast')
       
end