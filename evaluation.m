function evaluation(name, strategies, display_figure)

    if nargin < 2
        error('Not enough input arguments.')
    elseif nargin < 3
         display_figure = true;
    end
    
    evaluation_dir = fullfile('evaluation', name);
    if ~isdir(evaluation_dir)
       error('Evaluation files does not exists')
    end
    
 
    if display_figure
        result = zeros(length(strategies), 2);

        % '1': row offset to skip header liner; '%u32 %u16 %u16'
        C = readLog(fullfile(evaluation_dir, 'authors.csv'), '%s %s %s', 1);
        authors_ids = C{1};
        authors_num_citations = C{2};
        authors_num_publications = C{2};    

        for i = 1:length(authors_ids)
            result = result + plot_strategies(evaluation_dir, authors_ids(i), authors_num_citations(i), strategies);
        end
    else
        
        for i = 1:length(strategies)
            filename = fullfile(evaluation_dir, strcat('meta_', strategies{i}, '.csv'));
            C = readLog(filename, '%u32 %f %f %f %f', 1);
            
            %author_ids = C{1};
            author_num_citations = C{2};
            %author_num_publications = C{3}
            num_inspected_publications = C{4};
            num_citations = C{5};
            
            nc_ac = num_citations./author_num_citations;
            nc_np = num_citations./num_inspected_publications;
            figure
                hold on
                x_axis = 1:1:length(author_num_citations);
                [ax,p1,p2] = plotyy(x_axis, nc_ac, x_axis, nc_np, 'semilogy','plot');
                hold off
                grid on
                legend('nc/ac', 'nc_np * 100')
                title(strategies{i})
                xlabel(ax(1),'Mesurement')
                ylabel(ax(1),'#Citations / #Total Citations')
                ylabel(ax(2),'#Citations / #Inspected Publications')
        end
    end
end