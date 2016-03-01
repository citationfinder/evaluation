function [ C ] = readLog( fileName, format, numHeaderLines, delimiter )
% readLog - Reads a file log
%
%   Example:   readLog('example.txt', '%s %d')
%              readLog('example.txt', '%s %d', 5, '\t')
%
%   fileName: name of log file as string
%   format: format of the content of the file
%   [numHeaderLines]: number of header lines
%   [delimiter]: Delimiter e.g. ' ' (space), '\t' (tab) or ',' (comma)
%   return: maxtrix with log data
%

    if nargin < 2
        error('Not enough input arguments.');
    elseif nargin < 3
        numHeaderLines = 0;
    elseif nargin < 4
        delimiter = ','; % ' ' or 'space'
    end
    
    if ~exist(fileName, 'file')
       error('File not exists, path: %s', fileName); 
    end
    
    fid = fopen(fileName);
    C = textscan(fid, format, 'headerLines', numHeaderLines, 'Delimiter', delimiter );
    fclose(fid);
 
end