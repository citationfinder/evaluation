function evaluationClusterAuthors(evaluation_name, strategies)
% evaluationClusterAuthors - Create 3 bar plots for given strategies
% grouped by author classes: the effectiveness, efficiency and the
% number of inspected publication.
%
%   Example:   evaluationClusterAuthors('my-evaluation', {'my-strategy'})
%
%   evaluation_name: Name of the evaluation
%   strategies: Cell list of strategies
%

    if nargin < 2
        error('Not enough input arguments.')
    end

    evaluation_dir = getEvaluationDir(evaluation_name);
    
    % init
    effectiveness = zeros(length(strategies), 7);
    efficiency = effectiveness;
    inspected_publications = effectiveness;

    % legend
    fprintf('%s\t%s\t%s\t%s\n','effectiveness', 'efficiency', 'publications', 'strategy')
            
    for i = 1:length(strategies)
        filename = fullfile(evaluation_dir, strcat('meta_', strategies{i}, '.csv'));

        C = readLog(filename, '%u32 %f %f %f %f', 1);
        %author_ids = C{1};
        authors_num_citations = C{2};
        author_num_publications = C{3};
        num_inspected_publications = C{4};
        num_citations = C{5};
        

        authors_citation_no = [];
        authors_citation_few = [];
        authors_citation_medium = [];
        authors_citation_many = [];

        authors_publication_few = [];
        authors_publication_medium = [];
        authors_publication_many = [];

        for j = 1:length(authors_num_citations)          
            if authors_num_citations(j) == 0
                authors_citation_no = [authors_citation_no; j]; 
            elseif authors_num_citations(j) >= 1 && authors_num_citations(j) <= 99
                authors_citation_few = [authors_citation_few; j];
            elseif authors_num_citations(j) >= 100 && authors_num_citations(j) <= 999
                authors_citation_medium = [authors_citation_medium; j];
            elseif authors_num_citations(j) >= 1000
                authors_citation_many = [authors_citation_many; j];
            else
                warning('no class')
            end
            
            if author_num_publications(j) >= 10 && author_num_publications(j) <= 49
                authors_publication_few = [authors_publication_few; j];
            elseif author_num_publications(j) >= 50 && author_num_publications(j) <= 99
                authors_publication_medium = [authors_publication_medium; j];
            elseif author_num_publications(j) >= 100
                authors_publication_many = [authors_publication_many; j];
            else
                warning('no class')
            end
        end

        [effectiveness(i, 1), efficiency(i, 1), inspected_publications(i, 1)] = plotStrategy(strategies{i}, authors_num_citations, num_inspected_publications, num_citations);
        idx = authors_citation_few;
        [effectiveness(i, 2), efficiency(i, 2), inspected_publications(i, 2)] = plotStrategy(strcat(strategies{i}, '_citation_few (', int2str(length(authors_citation_few)),')'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx));
        idx = authors_citation_medium;
        [effectiveness(i, 3), efficiency(i, 3), inspected_publications(i, 3)] = plotStrategy(strcat(strategies{i}, '_citation_medium (', int2str(length(authors_citation_medium)),')'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx));
        idx = authors_citation_many;
        [effectiveness(i, 4), efficiency(i, 4), inspected_publications(i, 4)] = plotStrategy(strcat(strategies{i}, '_citation_many (', int2str(length(authors_citation_many)),')'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx));

        idx = authors_publication_few;
        [effectiveness(i, 5), efficiency(i, 5), inspected_publications(i, 5)] = plotStrategy(strcat(strategies{i}, '_publication_few (', int2str(length(authors_publication_few)),')'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx));
        idx = authors_publication_medium;
        [effectiveness(i, 6), efficiency(i, 6), inspected_publications(i, 6)] = plotStrategy(strcat(strategies{i}, '_publication_medium (', int2str(length(authors_publication_medium)),')'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx));
        idx = authors_publication_many;
        [effectiveness(i, 7), efficiency(i, 7), inspected_publications(i, 7)] = plotStrategy(strcat(strategies{i}, '_publication_many (', int2str(length(authors_publication_many)),')'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx));
        
    end

    legend_labels = {'Authors: all', ...
                     'Authors: few citations', ...
                     'Authors: several citations', ...
                     'Authors: many citations', ...
                     'Authors: few publications', ...
                     'Authors: several publications', ...
                     'Authors: many publications'};

    xaxis_labels = {'Author strategy', ...
                    'Journal strategy', ...
                    'Combination of all strategies'};
    figure
        b = bar(effectiveness);
        b(1).LineWidth = 2;
        b(1).EdgeColor = 'red';
        grid on
        set(gca,'xticklabel', xaxis_labels)
        ylabel('Effectiveness')
        legend(legend_labels, 'Location', 'northwest')

    figure
        b = bar(efficiency);
        b(1).LineWidth = 2;
        b(1).EdgeColor = 'red';
        grid on
        set(gca,'xticklabel', xaxis_labels)
        ylabel('Efficiency')
        legend(legend_labels, 'Location', 'northeast')

    figure
        b = bar(inspected_publications);
        b(1).LineWidth = 2;
        b(1).EdgeColor = 'red';
        grid on
        set(gca,'xticklabel', xaxis_labels)
        ylabel('Number of publications examined')
        legend(legend_labels, 'Location', 'northwest')

end
