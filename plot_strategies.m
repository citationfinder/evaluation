author_strategy = csvread('data/author_strategy/332714384.csv');
journal_strategy = csvread('data/journal_strategy/332714384.csv');

figure
    hold on
    plot(author_strategy(:,1), author_strategy(:,2), '.-')
    plot(journal_strategy(:,1), journal_strategy(:,2), '.-')    
    hold off
    grid on
    xlabel('inspected publications')
    ylabel('citations')
    legend('author strategy', 'journal strategy')