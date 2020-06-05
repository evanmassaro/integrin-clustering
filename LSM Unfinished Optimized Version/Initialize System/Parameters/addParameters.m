function Struct = addParameters(Struct,pairs)
    if ~isempty(pairs)
        for i = 1:length(pairs)
            C = strsplit(pairs{i}{1},'.');
            struct_name = C{1};
            field_name = C{2};
            value = pairs{i}{2};
            possible_fields = fieldnames(Struct);
            
            found_field = find(strcmp(field_name,possible_fields));
            if strcmp(struct_name,inputname(1))
                if ~isempty(found_field)
                    Struct = setfield(Struct,field_name,value);
                else
                    error('Invalid fieldname or parameter choice')
                end  
            end
        end
    end
end