function plot_strategies(evaluation_dir, author_id, author_num_citations, strategies)

    if nargin < 3
        error('Not enough input arguments.')
    elseif nargin == 3
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
            filename = char(fullfile(evaluation_dir, strategies{1}, strcat(author_id, '.csv')));
            if exist(filename, 'file')
                %try
                data = csvread(filename, 1);
                %if mod(i, 2) == 0
                %    linestyle = '.--';
                %else
                %    linestyle = '.-';
                %end
                plot(data(:,1), data(:,2), '.-')
                %catch
                %    plot(0, 0, '.-')
                %end
            else
                warning('File does not exists: %s', filename)
            end
        end
        hold off
        grid on
        %title(['Strategies comparison for user ', author_name, ' (', author_id, ')'])
        title(strcat('Strategies comparison for user ', author_id, ' (', author_num_citations, ')'))
        xlabel('inspected publications')
        ylabel('citations')
        legend(strategies, 'Location', 'southeast')
       
end