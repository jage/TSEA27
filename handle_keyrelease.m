function handle_keyrelease(h_obj,evt)
    global fig;
    global previous_key;

    %if(strcmp(evt.Key, previous_key))
    %    handle = guihandles(fig);
    %    set(handle.direction_edit, 'String', '0');
    %    guidata(fig, handle);
    %    sendconfig
    %    previous_key = 'false';
    %end % if
end