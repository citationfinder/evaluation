function evaluation(name, strategies, display_figure)

    if nargin < 2
        error('Not enough input arguments.')
    elseif nargin < 3
         display_figure = true;
    end
    
    evaluation_dir = fullfile('evaluation_data', name);
    if ~isdir(evaluation_dir)
       error('Evaluation files does not exists')
    end
    
 
    if display_figure
        result = zeros(length(strategies), 2);

        % '1': row offset to skip header liner; '%u32 %u16 %u16'
        C = readLog(fullfile(evaluation_dir, 'authors.csv'), '%s %f %f', 1);
        authors_ids = C{1};
        authors_num_citations = C{2};
        authors_num_publications = C{3};
        
        fprintf('num_publications, mean=%f, min=%f, max=%f\n', mean(authors_num_publications), min(authors_num_publications), max(authors_num_publications))
        fprintf('num_citations, mean=%f, min=%f, max=%f\n', mean(authors_num_citations), min(authors_num_citations), max(authors_num_citations))

        for i = 1:length(authors_ids)
            plot_strategies(evaluation_dir, authors_ids{i}, strategies, authors_num_publications(i), authors_num_citations(i));
        end
    else
        
        fprintf('%s\t%s\t%s\n','effectiveness', 'efficiency', 'strategy')
        for i = 1:length(strategies)
            filename = fullfile(evaluation_dir, strcat('meta_', strategies{i}, '.csv'));
            C = readLog(filename, '%u32 %f %f %f %f', 1);
            
            %author_ids = C{1};
            author_num_citations = C{2};
            %author_num_publications = C{3}
            num_inspected_publications = C{4};
            num_citations = C{5};
            
            % remove zeros
            idx = find(author_num_citations==0);
            %warning('Ignore %f', idx)
            author_num_citations(idx) = [];
            num_inspected_publications(idx) = [];
            num_citations(idx) = [];
            
            effectiveness = num_citations./author_num_citations;
            %effectiveness(isnan(effectiveness)) = 0;
            efficiency = num_citations./num_inspected_publications;
            %efficiency(isnan(efficiency)) = 0;

            effectiveness_mean = nanmean(effectiveness);
            efficiency_mean = nanmean(efficiency);

            fprintf('%f\t%f\t%s\n', effectiveness_mean, efficiency_mean, strategies{i})
            
            x_axis = 1:1:length(author_num_citations);
            %{
            figure(2+i)
                hold on
                
                [ax, h1, h2] = plotyy(x_axis, effectiveness, x_axis, efficiency, 'semilogy','plot');
                %h1.LineStyle = ':';
                %h2.LineStyle = ':';
                hold off
                grid on
                legend('nc/ac', 'nc/np')
                title(strategies{i})
                xlabel(ax(1),'Measurement')
                ylabel(ax(1),'Effectiveness #Citations / #Total Citations')
                ylabel(ax(2),'Efficiency #Citations / #Inspected Publications')
            %}
            figure(1)
                hold on
                plot(x_axis, effectiveness)
                %plot(get(gca,'xlim'), [effectiveness_mean effectiveness_mean])
                hold off
            figure(2)
                hold on
                plot(x_axis, efficiency)
                %plot(get(gca,'xlim'), [efficiency_mean efficiency_mean])
                hold off
                
        end
        
        
        figure(1)
            grid on
            legend(strategies)
            title('effectiveness')
            xlabel('Measurement')
            ylabel('Effectiveness')
        figure(2)
            grid on
            legend(strategies)
            title('efficiency')
            xlabel('Measurement')
            ylabel('efficiency')
    end
end