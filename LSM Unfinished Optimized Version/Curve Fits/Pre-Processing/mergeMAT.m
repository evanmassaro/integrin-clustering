function mergeMAT(filename,varargin)

    % Check to see that both files contain the same variables
    S_BASE = load(varargin{1});
    variables_BASE = fieldnames(S_BASE);
    for i = 2:nargin-1
        S = load(varargin{i});
        variables = fieldnames(S);
        if ~isequal(variables,variables_BASE)
            error('Different variables in these MAT-files')
        end
        
        % Concatenate data
        for k = 1:length(variables)
            S_BASE.(variables{k}) = [S_BASE.(variables{k}) S.(variables{k})];
        end
        
        
    end
    
    % Save result in a new file
    save(filename,'-struct','S_BASE')

end