function handle_keypress(h_obj, evt)
    global fig;
    global previous_key;
    
    if strcmp(evt.Key,previous_key)
    else
         handle = guihandles(fig);
         switch evt.Key
             case 'uparrow'
                 set(handle.direction_edit, 'String', '1');
                 %speed     = str2double(get(handle.max_speed_edit, 'String'));
                 %direction = str2double(get(handle.direction_edit, 'String'));
                 
                 %set(handle.max_speed_edit, 'String', (speed + 1));
             case 'downarrow'
                 set(handle.direction_edit, 'String', '2');
             case 'leftarrow'
                 set(handle.direction_edit, 'String', '4');
             case 'rightarrow'
                 set(handle.direction_edit, 'String', '3');
             case 'z'
                 set(handle.direction_edit, 'String', '6');
             case 'x'
                 set(handle.direction_edit, 'String', '5');
             case 'space'
                 set(handle.direction_edit, 'String', '0');
             otherwise
         end
         set(handle.status_text, 'String', sprintf('Got %s', evt.Key));
         guidata(fig, handle);
         sendconfig
    end % if

    previous_key = evt.Key;
end
