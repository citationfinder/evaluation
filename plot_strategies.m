function plot_strategies(author_id, author_name, author_num_publications, author_num_citations)
    strategies = {'author_strategy', 'journal_strategy', 'conference_strategy'};

    figure
        hold on
        for i=1:length(strategies)
            try
                data = csvread(['data/', strategies{i}, '/', author_id,'.csv']);
                plot(data(:,1), data(:,2), '.-')
            catch
                plot(0, 0, '.-')
            end
        end
        hold off
        grid on
        title(['Strategies comparison for user ', author_name, ' (', author_id, ')'])
        xlabel('inspected publications')
        ylabel('citations')
        legend(strategies, 'Location', 'southeast')
       
end