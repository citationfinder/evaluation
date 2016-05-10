function [effectiveness_mean, efficiency_mean, inspected_publications_mean] = plotStrategy(strategy_name, author_num_citations, num_inspected_publications, num_citations, do_plot)

    if nargin < 4
        error('Not enough input arguments.')
    elseif nargin < 5
        do_plot = false;
    end

    % remove zeros
    idx = find(author_num_citations==0);
    author_num_citations(idx) = [];
    num_inspected_publications(idx) = [];
    num_citations(idx) = [];
            
    effectiveness = num_citations./author_num_citations;
    %effectiveness(isnan(effectiveness)) = 0;
    efficiency = num_citations./num_inspected_publications;
    %efficiency(isnan(efficiency)) = 0;

    effectiveness_mean = nanmean(effectiveness);
    efficiency_mean = nanmean(efficiency);
    inspected_publications_mean = nanmean(num_inspected_publications);

    fprintf('%f\t%f\t%.2f\t%s\n', effectiveness_mean, efficiency_mean, inspected_publications_mean, strategy_name)
            
    if do_plot
        x_axis = 1:length(author_num_citations);

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

