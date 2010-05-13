function handle_keypress(h_obj,evt)
    global fig;
    handle = guihandles(fig);

     switch evt.Key
         case 'uparrow'
             set(handle.direction_edit, 'String', '1');
         case 'downarrow'
             set(handle.direction_edit, 'String', '2');
         case 'leftarrow'
             set(handle.direction_edit, 'String', '3');
         case 'rightarrow'
             set(handle.direction_edit, 'String', '4');
         case 'z'
             set(handle.direction_edit, 'String', '5');
         case 'x'
             set(handle.direction_edit, 'String', '6');
             
         otherwise
     end
     guidata(fig, handle);
     sendconfig
end
