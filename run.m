close all
%%

authors = {'332714384', 'sven groppe', '67', '307';
           '110255', 'henry etzkowitz', '118', '';
           '358326', 'peter fratzl', '418', '';
           '63266', 'antonio p strafella', '46', ''};

for i=1:size(authors, 1)
    plot_strategies(authors{i,:})
end