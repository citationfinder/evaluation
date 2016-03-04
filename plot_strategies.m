function plot_strategies(evaluation_dir, author_id, author_num_citations, strategies)

    if nargin < 4
        error('Not enough input arguments.')
    end
    
    %result = zeros(length(strategies), 2);

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
                %result(i,:) = [data(end,1), data(end,2)];
            else
                if display_figure
                    plot(0, 0, '.-')
                end
                %result(i,:) = [0, 0];
                %warning('File does not exists: %s', filename)
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