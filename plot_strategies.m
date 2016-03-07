function plot_strategies(evaluation_dir, author_id, strategies, author_num_publications, author_num_citations)

    if nargin < 3
        error('Not enough input arguments.')
    elseif nargin < 4
        author_num_publications = '';
        author_num_citations = '';
    elseif nargin < 5
        author_num_citations = '';
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
        title(sprintf('Strategies for user %s (pubs=%i, cit=%i)', author_id, author_num_publications, author_num_citations))
        xlabel('inspected publications')
        ylabel('citations')
        legend(strategies, 'Location', 'southeast')
       
end