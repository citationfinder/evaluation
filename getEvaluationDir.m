function [ evaluation_dir ] = getEvaluationDir( evaluation_name )

    evaluation_dir = fullfile('evaluation_data', evaluation_name);
    if ~isdir(evaluation_dir)
       error('Evaluation files does not exists')
    end

end

