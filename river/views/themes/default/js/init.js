sandbox.register_module('feedmanager', util.extend({
    title: 'Feed Manager'
    , last_check: 0
    , description: 'Handles adding/removing feeds from the db.'
    , open: false
    , uint: undefined
    , queue: undefined
    , initialize: function() {
        
        nobi.bind('keylogger-action-key', function(e) {
            var feedmanager = sandbox.request_module('feedmanager');
            if(feedmanager.open) {
                if(e.which === util.KEYS.ENTER) {
                    feedmanager.add(true);
                }
                else if(e.which === util.KEYS.ESCAPE) {
                    feedmanager.clear_dom();
                }
            }
            else {
                if(e.which === util.KEYS.A) {
                    feedmanager.add();
                }
            }
        });

        this.update();
        this.uint = setInterval(sandbox.request_module('feedmanager').update, 1000*60*1);
    }
    , update: function() {
        var fm = sandbox.request_module('feedmanager');
        fm.toggle_jaxer();
        async.get({url: 'index.php/?/river', last_checked: fm.last_check}, fm.display_feeds);
    }
    , add: function(should_add_feed) {
        if(should_add_feed) {
            var feed_url = document.getElementById('add_feed_input');
            async.post({url: 'index.php/?/river', data: {feed: feed_url.value}}, this.feed_added);
        }
        else {
            this.create_dom();
            document.getElementById('add_feed_input').focus();

            this.open = true;
        }
    }
    , feed_added: function(data) {
        var fm = sandbox.request_module('feedmanager');
        fm.open = false;
        fm.clear_dom();

        // clear interval, add the new feeds.
        fm.uint = undefined;
        fm.update();
        fm.uint = setInterval(sandbox.request_module('feedmanager').update, 1000*60*1);
    }
    , clear_dom: function() {
        var feed_input = document.getElementById('add_feed_input');
        feed_input.value = '';
        feed_input.parentNode.parentNode.removeChild(document.getElementById('add_feed'))
        this.open = false;
    }
    , create_dom: function() {
        var div = document.createElement('div')
            , input = document.createElement('input');

        div.setAttribute('id','add_feed');
        input.setAttribute('type','text');
        input.setAttribute('name','add_feed_input');
        input.setAttribute('id','add_feed_input');

        div.innerHTML = 'RSS Url: '
        div.appendChild(input);

        document.getElementsByTagName('body')[0].appendChild(div);
    }
    , parse: {
        site_item: function(item) {
            var tmp = '<table class="site-details"><tr>';
                tmp += '<tr><td class="favicon"><img src="'+item.favicon+'" width="16" height="16"></td>';
                tmp += '<th class="title"><a href="#">'+item.site_title+'</a></th>';
                tmp += '<td class="pub_date">&nbsp;</td></tr></table>';

                return tmp;
        }
        , feed_item: function(item) {
            var tmp = '<table class="entry">';
            tmp += '<tr><td class="favicon"></td>';
            tmp += '<th class="title"><a href="'+item.permalink+'">'+item.entry_title+'</a></th>';
            tmp += '<td class="pub_date">'+item.pub_date+'</td></tr></table>';

            return tmp;
        }
    }
    , display_feeds: function(data) {
        //data = JSON.parse(data);
        var fm = sandbox.request_module('feedmanager')
            , last_item = {site_title: undefined};


        console.log(data);
        data = eval('(' + data + ')');
        var pump = [];
        for(var i = 0, l = data.length; i < l; ++i) {
            if(last_item.site_title !== data[i].site_title) {
                pump.push(fm.parse.site_item(data[i]));
                last_item = data[i];
            }
            pump.push(fm.parse.feed_item(data[i]));

        }

        $('#entries').prepend(pump.join("\r\n"));
        fm.toggle_jaxer();
    }
    , toggle_jaxer: function() {
        if($('#jaxer').length > 0) {
            $('#jaxer').remove();
        }
        else {
            $('#river h2').after('<img src="images/jaxer.gif" id="jaxer">')
        }
    }
}, sandbox.module));

// hashbangs
$('a').click(function(e) {
    e.preventDefault();
    e.stopPropagation();


    switch($(this).attr('href')) {
        case '#!add_feed':
            sandbox.request_module('feedmanager').add();
            break;
    }

});
