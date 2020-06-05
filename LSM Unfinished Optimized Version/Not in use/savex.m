function savex(varargin)

% % save all variables that are present in the workspace EXCEPT what you
% % specify explicitly (by including the variable names or by using regular 
% % expressions).


varList = evalin('caller','who');
saveVarList = {};

if ismember(nargin,[0,1])
    % save all variables
    saveVarList = varList;
    for u = 1:numel(saveVarList)
        eval([saveVarList{u},' = evalin(',char(39),'caller',char(39),',',char(39),saveVarList{u},char(39),');'])
    end    
    save('matlab.mat',varList{:})
    
elseif strcmp(varargin{2},'-regexp')
    % save everything except the variables that match the regular expression
    
    optionsList = {};
    inputVars ={};
    for k=3:numel(varargin)
        if strcmp(varargin{k}(1),'-')
            optionsList{1,end+1} = varargin{k};
        else
            inputVars{1,end+1} = varargin{k};
        end
    end
    

    for k=1:numel(varList)
        
        matchCell = regexp(varList{k},inputVars,'ONCE');
       
        matchBool = repmat(false,size(matchCell));
        for m=1:numel(matchCell)
            if ~isempty(matchCell{m})
                matchBool(m) = true;
            end
        end
        if ~any(matchBool)
            saveVarList{end+1} = varList{k};
        end
    end

    for u = 1:numel(saveVarList)
        eval([saveVarList{u},' = evalin(',char(39),'caller',char(39),',',char(39),saveVarList{u},char(39),');'])
    end
    
    save(varargin{1},saveVarList{:},optionsList{:})
    
    
    
elseif ischar(varargin{1})
    % save everything except the variables that the user defined in
    % varargin{2:end}
    optionsList = {};
    inputVars = {};
    for k=2:numel(varargin)
        if strcmp(varargin{k}(1),'-')
            optionsList{1,end+1} = varargin{k};
        else
            inputVars{1,end+1} = varargin{k};
        end
    end
    
    for k=1:numel(varList)
        
        if ~ismember(varList{k},inputVars)

            saveVarList{end+1} = varList{k};
            
        end
        
    end

    for u = 1:numel(saveVarList)
        eval([saveVarList{u},' = evalin(',char(39),'caller',char(39),',',char(39),saveVarList{u},char(39),');'])
    end
    
    save(varargin{1},saveVarList{:},optionsList{:})
    
else
    error('Unknown function usage.')
end
    
    

