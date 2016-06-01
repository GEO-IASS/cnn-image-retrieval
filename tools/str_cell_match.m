function [match_index] = str_cell_match(main_str_cell,sub_str_cell)
%author sherwood
%input the main_str_cell and sub_str_cell
%main_str_cell:the cell contains str where string in sub_str_cell to find
%sub_str_cell:the find string
%match_index return index
match_index = [];
for i = 1:numel(main_str_cell)
    main_str = main_str_cell(i);
    main_str = main_str{1,1};
    for j = 1:numel(sub_str_cell)
        sub_str = sub_str_cell(j);
        sub_str = sub_str{1,1};
        if strfind(main_str,sub_str) | strfind(sub_str,main_str)
            match_index = [match_index i];
        end
    end
end


end

