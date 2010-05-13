function handle_keyrelease(h_obj,evt)
    global fig;
    handle = guihandles(fig);
    set(handle.direction_edit, 'String', '0');
    guidata(fig, handle);
    sendconfig
end