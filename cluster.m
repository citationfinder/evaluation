
evaluation_name = 'cluster';
ids = {'10169007', '13144211', '37879656', '165559636'};

evaluation_dir = getEvaluationDir(evaluation_name);

N = length(ids);

fieldofstudies = zeros(100, N);
fieldofstudies_count = fieldofstudies;

for i=1:N
    C = readLog(fullfile(evaluation_dir, strcat(ids{i},'.csv')), '%f %f', 1);
    fieldofstudies(:,i) = C{1};
    fieldofstudies_count(:,i) = C{2};
    
end

result = zeros(N, N);
lim = 1:size(fieldofstudies,1)/2;
for i=1:N
    for j=i:N
        result(j, i) = length(intersect(fieldofstudies(lim,i), fieldofstudies(lim,j)));
    end
end

result