function [effectiveness_mean, efficiency_mean] = plotStrategy(strategy_name, author_num_citations, num_inspected_publications, num_citations, plot)

    if nargin < 4
        error('Not enough input arguments.')
    elseif nargin < 5
        plot = false;
    end

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

            fprintf('%f\t%f\t%s\n', effectiveness_mean, efficiency_mean, strategy_name)
            
    if plot
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

end
