function evaluationClusterAuthors(name, strategies)

    if nargin < 2
        error('Not enough input arguments.')
    end

    evaluation_dir = fullfile('evaluation_data', name, filesep);
    if ~isdir(evaluation_dir)
       error('Evaluation files does not exists')
    end

    %{
    % '1': row offset to skip header liner; '%u32 %u16 %u16'
    C = readLog(fullfile(evaluation_dir, 'authors.csv'), '%d %f %f', 1);
    authors_ids = C{1};
    authors_num_citations = C{2};
    authors_num_publications = C{3};
    %}

    authors_citation_no = [];
    authors_citation_few = [];
    authors_citation_medium = [];
    authors_citation_many = [];
    %{
    for i = 1:length(authors_num_citations)
        if authors_num_citations(i) == 0
            authors_citation_no = [authors_citation_no authors_ids(i)]; 
        elseif authors_num_citations(i) >= 1 && authors_num_citations(i) <= 99
            authors_citation_few = [authors_citation_few authors_ids(i)];
        elseif authors_num_citations(i) >= 100 && authors_num_citations(i) <= 999
            authors_citation_medium = [authors_citation_medium authors_ids(i)];
        elseif authors_num_citations(i) >= 1000
            authors_citation_many = [authors_citation_many authors_ids(i)];
        else
            warning('no class')
        end
    end
    %}
    
    for i = 1:length(strategies)
        filename = fullfile(evaluation_dir, strcat('meta_', strategies{i}, '.csv'));

        C = readLog(filename, '%u32 %f %f %f %f', 1);
        %author_ids = C{1};
        authors_num_citations = C{2};
        num_inspected_publications = C{4};
        num_citations = C{5};

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
        end

        fprintf('no:%i\tfew:%i\tmedium:%i\tmany:%i\n', length(authors_citation_no),length(authors_citation_few), length(authors_citation_medium), length(authors_citation_many))
        fprintf('%s\t%s\t%s\n','effectiveness', 'efficiency', 'strategy')
        
        idx = authors_citation_few;
        plotStrategy(strcat(strategies{i}, '_few'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx))
        idx = authors_citation_medium;
        plotStrategy(strcat(strategies{i}, '_medium'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx))
        idx = authors_citation_many;
        plotStrategy(strcat(strategies{i}, '_many'), authors_num_citations(idx), num_inspected_publications(idx), num_citations(idx))
        
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
        %{
        
        strategy_path = fullfile(evaluation_dir, strategies{i}, filesep);
        files = dir([strategy_path, '*.csv']);
        for file = files'
            %[~, author_id, ~] = fileparts(file.name);
            author_id = str2num(strrep(file.name, '.csv', ''));

            data = csvread([strategy_path, file.name], 1);
            total_inspected_publications = data(end, 1);
            total_citations = data(end, 2);
            
            if any(authors_citation_few==author_id)
               
            elseif any(authors_citation_medium==author_id)
            
            elseif any(authors_citation_many==author_id)
                
            end
            
        end
        
        %}
    end
 
  
end