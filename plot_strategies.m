id = '332714384';
strategies = {'author_strategy', 'journal_strategy', 'conference_strategy'};

figure
    hold on
    for i=1:length(strategies)
        data = csvread(['data/', strategies{i}, '/', id,'.csv']);
        plot(data(:,1), data(:,2), '.-')
    end
    hold off
    grid on
    title(['Strategies comparison for user ', id])
    xlabel('inspected publications')
    ylabel('citations')
    legend(strategies)