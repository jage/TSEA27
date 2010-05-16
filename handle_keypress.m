function handle_keypress(h_obj, evt)
    global fig;
    global previous_key;

     handle = guihandles(fig);
     switch evt.Key
         case 'uparrow'
             set(handle.direction_edit, 'String', '1');
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
     set(handle.status_text, 'String', sprintf('Hanterade ett %s', evt.Key));
     guidata(fig, handle);
     senddirection

    previous_key = evt.Key;
end
