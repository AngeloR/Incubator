var APP_MODE = 0;           // 0 for debug, 1 for production
function set_ui() {
    $('#content').css('width',$(window).width()-$('#sidebar').width()-1);
    $('#content').css('height',$(window).height()-$('#topbar').height());
    $('#sidebar').css('height',$(window).height()-$('#topbar').height());
    $('#sidebar ul').css('height',$('#sidebar').height()-$('#actions').height());

    $('.note').css('width',$('#content').width());
    $('#note-text').css('height',$('#content').height()*0.8);

    $('#search-container').css('top',$('#topbar').height()/2-$('#search-container').height()/2);
}

$(window).resize(function(e) {
    set_ui();
});

set_ui();

window.console = (!window.console || APP_MODE)?{
    log: function() {}
    , error: function() {}
}:window.console;


sandbox.register_module('ns',util.extend({
    title: 'Note System'
    , description: 'Manages all notes'
    // base api url
    , base_url: '../index.php/?/'
    // temp cache. Don't rely on it for anything
    , tmp: {}
    // interval to ensure that we're not spamming the search
    , searchint: undefined
    // used to track autosaving
    , autosave: undefined
    // Adds a note to the sidebar
    , add_note_to_sidebar: function(note) {
        var li = document.createElement('li')
            , a = document.createElement('a')
            , span = document.createElement('span');

        span.className = 'helptext';
        span.innerHTML = note.note_description;
        a.setAttribute('id','note-'+note.note_id);
        a.innerHTML = note.note_title;
        a.setAttribute('href','#');
        a.appendChild(span);
        li.appendChild(a);

        document.getElementById('nav').appendChild(li);
    }
    // set this note as the "selected" one
    , set_selected: function(note_id) {
        $.each($('#nav li'), function(i,obj) {
            $(obj).removeAttr('id');
        });

        $('#note-'+note_id).parent().attr('id','selected');
    }

    // shows note information
    , show_info: function(note) {
        $('#note-title').val(note.note_title);
        $('#note-text').val(note.note_text);
        $('#note-id').val(note.note_id);

        if($('#note-id').val()!== '') {
            $('#delete').removeAttr('disabled');
        }
    }

    // get info about a note
    , get_info: function(note_id) {
        $.ajax({
            url: this.base_url+'notes/'+note_id
            , dataType: 'json'
            , type: 'get'
            , success: function(res) {
                if(res.status === 'success') {
                    sandbox.request_module('ns').show_info(res.data[0]);
                    $('#note-text').focus();
                }
                else {
                    console.error('Woops, there was a problem loading the note details.');
                }
            }
        });
    }

    // Get note list
    , get_list: function() {
        $.ajax({
            url: this.base_url+'notes'
            , type: 'get'
            , dataType: 'json'
            , success: function(res) {
                if(res.status === 'success') {
                    if(res.data.length > 0) {
                        for(var i = 0, l = res.data.length; i < l; ++i) {
                            sandbox.request_module('ns').add_note_to_sidebar(res.data[i]);
                        }
                        sandbox.request_module('ns').set_selected(res.data[0].note_id);
                        sandbox.request_module('ns').get_info(res.data[0].note_id);
                    }
                }
                else {
                    console.error('Sorry, we couldn\'t get your list of notes.');
                }
            }
        });
    }

    // save the note
    , save: function(cb) {
        var note = {
            note_id: $('#note-id').val()
            , note_title: $('#note-title').val()
            , note_text: $('#note-text').val()
            , note_description: $('#note-text').val().substr(0,50)
        };

        console.log(note,'being sent');

        $.ajax({
            url: sandbox.request_module('ns').base_url+'notes'
            , dataType: 'json'
            , data: note
            , type: 'post'
            , success: function(res) {
                if(res.status === 'success') {
                    nobi.notify('note-saved');
                    // check if it's a new post'
                    if($('#note-'+res.data[0].note_id).length === 1) {
                        // we just updated an existing entry
                        console.log('Saved - existing note',res);

                        var desc = $('#note-text').val().substr(0,50);

                        $('#note-'+res.data[0].note_id).html($('#note-title').val()+'<span class="helptext"></span>');
                        $('#note-'+res.data[0].note_id+' span').html(desc);

                    }
                    else {
                        // we just created a new entry
                        console.log('Saved - new note',res);
                        $('#note-id').val(res.data[0].note_id);
                        $('#nav').append('<li><a href="#" id="note-'+res.data[0].note_id+'">'+$('#note-title').val()+'<span class="helptext">'+$('#note-text').val().substr(0,50)+'</span></a></li>');
                        sandbox.request_module('ns').set_selected(res.data[0].note_id);
                    }
                    $('#save').attr('disabled','disabled');


                    if(cb) {
                        cb();
                    }
                }
                else {
                    console.error('Whoops, there was a problem saving your note.');
                }
            }
            , error: function(res) {
                console.log(res.responseText);
            }
        });
    }

    // Saves the current note, and then clears the page.
    , new_note: function() {
        var ns = sandbox.request_module('ns');
        if($('#note-title').val() !== '') {
            ns.save(ns.clear);
        }
        else {
            ns.clear();
        }
        if($('#preview').html() === 'Edit Mode') {
            $('#preview-area').hide();
            $('#note').show();
            $('#preview').html('Preview');
        }
        $('#note-title').focus();
    }

    // preview a note
    , preview: function() {
        var note_id = $('#note-id').val()
            , ns = sandbox.request_module('ns');

        if($('#preview').html() === 'Preview') {
            $.ajax({
                url: ns.base_url+'preview/'
                , dataType: 'json'
                , data: {note_title: $('#note-title').val(), note_text: $('#note-text').val()}
                , type: 'post'
                , success: function(res) {
                    $('#preview-area').html(res.data).show();
                    $('#note').hide();
                    $('#preview').html('Edit Mode');
                }
            });
        }
        else {
            $('#preview-area').hide();
            $('#note').show();
            $('#preview').html('Preview');
        }
    }

    // delete a note from the db
    , remove: function() {
        var note_id = $('#note-id').val();

        $.ajax({
            url: this.base_url+'notes/'+note_id
            , data: {_method: 'delete'}
            , dataType: 'json'
            , type: 'post'
            , success: function(res) {
                 nobi.notify('note-removed');
                $('#selected').remove();
                var new_note_id = $('#nav a').attr('id').split('note-')[1];
                sandbox.request_module('ns').set_selected(new_note_id);
                sandbox.request_module('ns').get_info(new_note_id);
            }
        });
    }

    // search your notes (text/title) for your note
    , search: function() {
        var ns = sandbox.request_module('ns')
            , search_text = $('#search').val();

        if(search_text.length > 3) {
            $.ajax({
                url: ns.base_url+'search/'+search_text
                , dataType: 'json'
                , type: 'get'
                , success: function(res) {
                    if(res.status === 'success') {
                        if(res.data.length > 0) {
                            // we had some results
                            var tmp = '';
                            for(var i = 0, l = res.data.length; i < l; ++i) {
                                tmp += '<li><a href="'+res.data[i].note_id+'">'+res.data[i].note_title+'</a></li>';
                            }

                            $('#search-results').html(tmp).show();
                        }
                        else {
                            $('#search-results').html('<li><a href="#">No results</a></li>').show();
                        }
                    }
                    else {
                        console.log('Sorry, there seems to be a problem with our database.',res);
                    }
                }
            });
        }
    }

    // clear all form fields
    , clear: function() {
        $('#note-id').val('');
        $('#note-title').val('');
        $('#note-text').val('');
    }

    // autorun once
    , initialize: function() {
        this.get_list();

        $('a[id^=note-]').live('click', function(e) {
            e.preventDefault();
            e.stopPropagation();

            var ns = sandbox.request_module('ns')
                , note_id = $(this).attr('id').split('-')[1];

            ns.set_selected(note_id);
            ns.get_info(note_id);
        });

        $('#note-title').keyup(function(e) {
            if($(this).val() !== '') {
                var ns = sandbox.request_module('ns');
                $('#save').removeAttr('disabled');

                if(ns.autosave) {
                    clearTimeout(ns.autosave);
                    ns.autosave = setTimeout(ns.save,1000);
                }
                else {
                    ns.autosave = setTimeout(ns.save,1000);
                }
            }
            if($('#note-id').val()!== '') {
                $('#delete').removeAttr('disabled');
            }
        });

        $('#note-text').keyup(function(e) {
            if($(this).val() !== '' && $('#note-title').val() !== '') {
                var ns = sandbox.request_module('ns');
                $('#save').removeAttr('disabled');

                if(ns.autosave) {
                    clearTimeout(ns.autosave);
                    ns.autosave = setTimeout(ns.save,1000);
                }
                else {
                    ns.autosave = setTimeout(ns.save,1000);
                }
            }
            if($('#note-id').val()!== '') {
                $('#delete').removeAttr('disabled');
            }
        });

        $('#new-note').click(function(e){
            e.preventDefault();
            e.stopPropagation();

            sandbox.request_module('ns').new_note();
        });


        $('#save').click(function(e){
            var ns = sandbox.request_module('ns');
            ns.save();
            return false;
        });

        $('#delete').click(function(e){
            var ns = sandbox.request_module('ns');
            ns.remove();
            ns.clear();
            return false;
        });

        $('#preview').click(function(e){
            e.preventDefault();
            e.stopPropagation();

            var ns = sandbox.request_module('ns');
            ns.preview();
        });

        $('#logout-action').click(function(e){
            e.preventDefault();
            e.stopPropagation();

            window.location = 'logout';
        });

        $('#search').keyup(function(e){
            if($(this).val().length > 3) {
                var ns = sandbox.request_module('ns');
                if(ns.searchint) {
                    clearTimeout(ns.searchint);
                }
                ns.searchint = setTimeout(ns.search, 600);
            }
        });

        $('#search').blur(function(e){
            setTimeout(function() {
                $('#search-results').hide().html('');
            },600);
        });

        $('#search-container a').live('click',function(e){
            e.preventDefault();
            e.stopPropagation();
            var note_id = $(this).attr('href')
                , ns = sandbox.request_module('ns');
            
            ns.tmp.search = note_id;

            if(note_id.charAt(0) !== '#') {
                ns.save(function() {
                    var ns = sandbox.request_module('ns');
                    console.log($('#note-id').val(),ns.tmp.search);
                    ns.get_info(ns.tmp.search);
                    ns.set_selected(ns.tmp.search);
                });
            }
            $('#search_results').hide().html('');
            
        });
    }
}, sandbox.module));

sandbox.register_module('settings', util.extend({
    title: 'Settings Manager'
    , description: 'Defines user settings'
    // Shows the settings wizard
    , show: function() {
        $('#overlay').show();
        $('#settings').show();
    }

    // Hides the settings wizard
    , hide: function() {
        $('#overlay').hide();
        $('#settings').hide();
    }

    // Display tab
    , tab: function(name) {

        switch(name) {
            case 'General':
                $('#account').hide();
                $('#theme').hide();
                $('#general').show();
                $('#about').hide();
                break;
            case 'Account':
                $('#account').show();
                $('#theme').hide();
                $('#general').hide();
                $('#about').hide();
                break;
            case 'Theme':
                $('#account').hide();
                $('#theme').show();
                $('#general').hide();
                $('#about').hide();
                break;
            case 'About':
                $('#account').hide();
                $('#theme').hide();
                $('#general').hide();
                $('#about').show();
                break;
        }
    }

    , initialize: function() {
        $('#settings-action').click(function(e){
            e.preventDefault();
            e.stopPropagation();

            var settings = sandbox.request_module('settings');
            settings.show();
        });

        this.tab('General');


        $('#sections li').click(function(e){
            e.preventDefault();
            e.stopPropagation();

            
            $.each($(this).siblings(), function(i,obj){
                $(obj).removeAttr('id');
            })
            $(this).attr('id','selected-settings');

            if($(this).html().split('General').length === 2) {
                sandbox.request_module('settings').tab('General');
            }
            else if($(this).html().split('Theme').length === 2) {
                sandbox.request_module('settings').tab('Theme');
            }
            else if($(this).html().split('Account').length === 2) {
                sandbox.request_module('settings').tab('Account');
            }
            else if($(this).html().split('About').length === 2) {
                sandbox.request_module('settings').tab('About');
            }
        });

        $('#overlay').click(function(e){
            sandbox.request_module('settings').hide();
        });

        $('#settings').css('left',$(window).width()/2-$('#settings').width()/2);
        $('#settings').css('top',$(window).height()/2-$('#settings').height()/2);

        $(window).resize(function(){
            $('#settings').css('left',$(window).width()/2-$('#settings').width()/2);
            $('#settings').css('top',$(window).height()/2-$('#settings').height()/2);
        });
    }
}, sandbox.module));


sandbox.register_module('keyboard-shortcuts', util.extend({
    title: 'Keyboard Shortcuts'
    , description: 'Adds keyboard shortcuts to the system'
    , initialize: function() {
        shortcut.add('Ctrl+Space', function(){
            $('#search').focus();
        });

        shortcut.add('Esc', function(){
            $('*:focus').blur();
        });

        shortcut.add('Ctrl+Alt+N', function(){
            sandbox.request_module('ns').new_note();
        });
    }
},sandbox.module));