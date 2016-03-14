function evaluationClusterAuthors(name, strategies)

    if nargin < 2
        error('Not enough input arguments.')
    end

    evaluation_dir = fullfile('evaluation_data', name, filesep);
    if ~isdir(evaluation_dir)
       error('Evaluation files does not exists')
    end

    
    % '1': row offset to skip header liner; '%u32 %u16 %u16'
    C = readLog(fullfile(evaluation_dir, 'authors.csv'), '%s %f %f', 1);
    authors_ids = C{1};
    authors_num_citations = C{2};
    authors_num_publications = C{3};
    
    %author_set;
    authors_citation_no = [];
    authors_num_citations = [];
    authors_citation_medium = [];
    authors_citation_many = [];
    for i = 1:length(authors_num_citations)
        if authors_num_citations(i) == 0
            authors_citation_no = [authors_citation_no authors_ids(i)]; 
        elseif authors_num_citations(i) >= 1 && authors_num_citations(i) <= 99
            authors_citation_few = [authors_citation_few authors_ids(i)];
        elseif authors_num_citations(i) >= 100 && authors_num_citations(i) <= 999
            authors_citation_medium = [authors_citation_medium authors_ids(i)];
        elseif authors_num_citations(i) >= 1000
            authors_citation_many = [authors_citation_many authors_ids(i)];
        end
    end
    
    for i = 1:length(strategies)
        path = fullfile(evaluation_dir, strategies{i}, filesep)
        files = dir([path, '*.csv']);
        for file = files'
            data = csvread([path, file.name], 1);
            data(end, 1)
            data(end, 2)
            
            [~, name, ~] = fileparts(file.name);
        end
    end
 
  
end