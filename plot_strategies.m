function plot_strategies(author_id, author_name, author_num_publications, author_num_citations, strategies)

    if nargin < 4
        error('Not enough input arguments.')
    elseif nargin >= 4 && nargin < 5
        strategies = {'author', ...
                      'journal', ...
                      'conference', ...
                      'fieldofstudy-ordered-limit', ...
                      'author-ordered-minyear-recursive+journal-ordered-minyear+conference-ordered-minyear+fieldofstudy-ordered-limit', ...
                      };
    end

    figure
        hold on
        for i=1:length(strategies)
            try
                data = csvread(['citationfinder/', strategies{i}, '/', author_id,'.csv']);
                %if mod(i, 2) == 0
                %    linestyle = '.--';
                %else
                %    linestyle = '.-';
                %end
                plot(data(:,1), data(:,2), '.-')
            catch
                plot(0, 0, '.-')
            end
        end
        hold off
        grid on
        %title(['Strategies comparison for user ', author_name, ' (', author_id, ')'])
        title(['Strategies comparison for user ', author_id])
        xlabel('inspected publications')
        ylabel('citations')
        legend(strategies, 'Location', 'southeast')
       
end