function [ evaluation_dir ] = getEvaluationDir( evaluation_name )
% getEvaluationDir - Get evaluation directory from it's name
%
%   Example:   getEvaluationDir('my-evaluation')
%
%   evaluation_name: Name of the evaluation
%
%   evaluation_dir: Full file name to the evaluation directory
%

    evaluation_dir = fullfile('evaluation_data', 'strategies', evaluation_name);
    if ~isdir(evaluation_dir)
       error('Evaluation directory does not exists: %s', evaluation_dir)
    end

end

