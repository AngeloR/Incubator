
(function(){

    /**
     * Nobi provides a simple internal event model. By tying objects together via
     * events we can be certain that objects that rely on other objects don't break
     * due to any unforseen errors that were to occur.
     *
     * It has standard notify/bind methods, but also provides an intercept/clear
     * interface. This allows objects to jump ahead of the notification queue,
     * however, only one object may do this. Multiple calls to intercept will force
     * only the last call to be "intercepted".
     *
     * Intercept is a system only resource that is available to allow developers
     * to intercept any potential points of failure.
     */
    var nobi = (function(){
        var commands = {};
        var catchall = {};

        return {
            notify: function(event,args) {
                if(catchall[event]) {
                    catchall[event].callback.apply(catchall[event].scope,[args]);
                }
                else {
                    for(i in commands[event]) {
                        commands[event][i].callback.apply(commands[event][i].scope,[args])
                    }
                }
            }
            , bind: function(event,cb,scope) {
                if(commands[event] === undefined) {
                    commands[event] = [];
                }

                commands[event].push({
                    callback: cb
                    , scope: scope || window
                });

            }
            , intercept: function(event,cb,scope) {
                catchall[event] = {
                    callback: cb
                    , scope: scope || window
                }
            }
            , intercepting_on: function() {
                return catchall;
            }
            , clear: function(event) {
                catchall[event] = undefined;
            }
        }
    })();

    window.nobi = (window.nobi === undefined)?nobi:window.nobi;

})();

/**
 * The sandbox object allows for modular development. By creating "modules" we can
 * add/remove features at will, WHEN THE GAME IS LIVE, without breaking anything.
 *
 * Modules have certain core attributes (id,developer,version) but are otherwise
 * freeform. If a module contains an "initialize" function, it will be called then
 * the module is registered.
 *
 * If a module needs to perform an action based on another out-come, see nobi.
 */
window.sandbox = window.sandbox || (function(){
    var modules = {};

    return {
        register_module: function(module,implementation,force) {
            if(!modules[module] || force) {
                modules[module] = implementation;

                nobi.notify('sandbox-module-registered',module);

                if(implementation.initialize !== undefined) {
                    implementation.initialize.call(implementation);
                }
            }
            else {
                console.error(module+' already exists.');
            }
        }
        , request_module: function(module) {
            return modules[module];
        }
        , module: {
            developer: 'Oryole Development Team'
            , version: 0.1
            , title: 'Sample Module'
            , description: 'Module description'
        }
    };
})();


/**
 * The util method provides some use methods. Think of it as a library of useful
 * features that should be referenced. If it's something that is required for your
 * code, chances are you'll find it here.
 */
window.util = window.util || {
    check: {
        isArray: function(obj) {
            return toString.call(obj) === '[object Array]';
        }
    }
    , extend: function(o,source) {
        for(var i in source) {
            if(!o[i]) {
                if(this.check.isArray(source[i])) {
                    o[i] = [];
                    this.extend(o[i],source[i]);
                }
                o[i] = source[i];
            }
        }
        return o;
    }
    , clone: function(source) {
        return this.extend({},source);
    }
    , each: function(obj,callback) {
        for(i in obj) {
            callback(i,obj[i]);
        }
    }
    , KEYS: {
        ENTER: 13
        , SHIFT: 16
        , ESCAPE: 27
        , FORWARD_SLASH: 191
        , ARROW_DOWN: 40
        , ARROW_UP: 38
        , ARROW_LEFT: 37
        , ARROW_RIGHT: 39
        , A: 65
        , B: 66
        , C: 67
        , D: 68
        , E: 69
        , F: 70
        , G: 71
        , H: 72
        , I: 73
        , J: 74
        , K: 75
        , L: 76
        , M: 77
        , N: 78
        , O: 79
        , P: 80
        , Q: 81
        , R: 82
        , S: 83
        , T: 84
        , U: 85
        , V: 86
        , W: 87
        , X: 88
        , Y: 89
        , Z: 90
    }
};

/**
 * Instead of bringing in an entirely new library to handle asynchronous calls to
 * the server, I opted to write a quick little async window.async method. I want
 * it available to everyone, so it exists as a global.
 */
window.async = window.async || (function(){
    var default_opt = {
            url: '/'
            , async: true
            , data: {}
        }
        , xhr = function(){
            try { return new XMLHttpRequest(); } catch(e) {}
            try { return new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) {}
            console.error('XMLHttpRequest not supported.');
            return null;
        }

    return {
        init: function(opt) {
            opt.url = opt.url || default_opt.url;
            opt.async = opt.async || default_opt.async;
            opt.data = this.massage_params(opt.data);
            return opt;
        }
        , massage_params: function(params) {
            var data = '';
            for(i in params) {
                console.log(i,params[i]);
                data += i+'='+params[i]+'&';
            }
            return data.slice(0,data.length-1);
        }
        , get: function(opt,cb) {
            var request = xhr();
            opt = this.init(opt);
            var params = (opt.data.length > 0)?'?'+opt.data:'';

            request.open('GET',opt.url+params,opt.async);
            request.onreadystatechange = function() {
                if(request.readyState === 4) {
                    cb(request.responseText);
                }
            }
            request.send(null);
            
        }
        , post: function(opt,cb) {
            var request = xhr();
            opt = this.init(opt);

            request.open('POST', opt.url, opt.async);
            request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.onreadystatechange = function() {
                if(request.readyState === 4) {
                    cb(request.responseText);
                }
            }
            request.send(opt.data);
        }
    }
})();

/**
 * The dom object allows us to decouple our reliance on a particular javascript
 * library. In this way we can modify a single object in our game and leave every
 * other module unaffected.
 *
 * Dom will serve as a simple wrapper for the moment, but at later times some
 * of these may be re-written for speed concerns.
 */
window.dom = window.dom || {
    event: {
        bind: function(el,event,callback) {
            $(el).bind(event,callback);
        }
        , unbind: function(el,event,callback) {
            $(el).unbind(event,callback);
        }
        , live: function(el,event,callback) {
            $(el).live(event,callback);
        }
        , die: function(el,event,callback) {
            $(el).die(event,callback);
        }
    }
}

/**
 * Sample keypress module.
 *
 * This module will probably need a bit of work, but right now it handles all
 * keypresses and maps them to the appropriate functions. If this module ever fails
 * NO keypresses will work, but the user will not receive any error messages, nor
 * will anything unexpected happen.
 */
sandbox.register_module('keylogger', util.extend({
    title: 'keylogger'
    , keys: {}
    , description: 'Figures out which keys were pressed and sends the appropriate notification.'
    , initialize: function(){
        dom.event.bind('body','keyup',function(e) {
            nobi.notify('keylogger-action-key', e);
        });
        nobi.bind('keylogger-action-key',sandbox.request_module('keylogger').keyup_handler,sandbox.request_module('keylogger'));
    }
    , watch: function(keylist, cb, scope) {
        keylist += '';
        if(!this.keys[keylist]) {
            this.keys[keylist] = []
        }
        this.keys[keylist].push({
            callback: cb
            , scope: scope || window
        });
    }
    , keyup_handler: function(e) {
        var agnostic = e.which
            , requires_shift = [e.which,'true'].join('+')
            , no_shift = [e.which,'false'].join('+')
            , key = undefined;

        if(this.keys[requires_shift] !== undefined && e.shiftKey) {
            key = requires_shift;
        }
        else if (this.keys[no_shift] !== undefined && !e.shiftKey) {
            key = no_shift;
        }
        else if(this.keys[agnostic] !== undefined){
            key = agnostic;
        }
        else {
            return;
        }

        console.log(this.keys[key]);

        util.each(this.keys[key], function(i,obj) {
            obj.callback.apply(obj.scope,[e]);
        });
    }
}, sandbox.module));


/**
 * Early chat module (sans-socketio).
 *
 * Eventually this module will be fleshed out to use socket.io to send messages
 * to the server. Also, it will bind to the ('chat-message-received') event that
 * is fired when socket.io returns a call.
 */
sandbox.register_module('chat',util.extend({
    title: 'chat'
    , el: null
    , initialize: function() {
        this.render();      // create chat dom
        this.events();      // bind events
    }
    , render: function() {
        this.el = '';
    }
    , events: function() {
        // bind to socket message received
        nobi.bind('socket-connection', function() {

        });

        nobi.bind('socket-message', function(msg) {

        });

        nobi.bind('socket-disconnect', function(){

        });

        dom.event.bind(this.el,'focus',function(e) {
            sandbox.request_module('keylogger').watch(util.KEYS.ENTER, function(e) {
                nobi.intercept('keylogger-action-key', this.capture(e));
            }, this);
        });

        dom.event.bind(this.el,'blur',function(e) {
            nobi.clear('keylogger-action-key');
        });
    }
    , capture: function(e) {
        console.log(String.fromCharCode(e.which));
        nobi.clear('keylogger-action-key');
        var message;
        
        if(e.which === util.KEYS.ENTER) {
            message = this.el.value;
            this.el.value = '';

            var messageObj = {

            }
            this.send(messageObj);
            this.displayMessage(messageObj);
        }
    }
    , send: function(messageObj) {
        // send via socket.io
    }
    , displayMessage: function(messageObj) {

    }
},sandbox.module));

/**
 * Will use this to flesh out the various windows. Check out below to see how
 * various versions can exist.
 */

sandbox.register_module('window',util.extend({
    title: 'window'
    , modes: {portrait: true,landscape: true}
    , opt: undefined
    , create: function(opt) {
        opt.title = opt.title || 'Window Title';
        opt.mode = (opt.mode && this.modes[opt.mode.toLowerCase()])?opt.mode.toLowerCase():'portrait';
        this.opt = opt;
        return this;
    }
    , render: function(display) {
        var div = document.createElement('div');
        div.innerHTML = this.opt.title+'|'+this.opt.mode;
        if(display !== undefined && !display) {
            div.style.display = 'none';
        }
        else {
            div.style.display = 'inline-block';
        }
        document.getElementsByTagName('body')[0].appendChild(div);

        if(this.opt.keycode) {
            if(this.opt.shiftKey !== undefined) {
                this.opt.keycode = [this.opt.keycode,this.opt.shiftKey].join('+');
            }
            sandbox.request_module('keylogger').watch(this.opt.keycode, function(e) {
                e.preventDefault();
                e.stopPropagation();

                div.style.display = (div.style.display === 'none')?'inline-block':'none';
                console.log(this.opt.title);
            }, this)
        }
    }
},sandbox.module));

sandbox.register_module('mob', util.extend({
    title: 'Monster Manager'
    , description: 'Manages monsters on the screen'
    , monsters: {}
    , initialize: function() {

    }
    , definition: function() {
        return {
            movement: [0,0,0,0]     // North, South, East West
            , start: [0,0]          // Top, Left
            , speed: 3              // movement speed
        };
    }
    , create: function(name,symbol,definition) {
        var span = document.createElement('span');
        span.innerHTML = symbol || 'x';
        span.className = 'mob';
        span.style.position = 'absolute';
        span.style.top = definition.start[1]+'px'
        span.style.left = definition.start[0]+'px'
        definition.dom = span;

        if(!this.monsters[name]) {
            this.monsters[name] = [];
        }

        this.monsters[name].push(definition);
        setInterval(this.move,definition.speed*1000,definition);

        document.getElementsByTagName('body')[0].appendChild(span);

        return this.monsters[name].length-1;
    }
    , move: function(definition) {
        var dir = Math.floor(Math.random()*5)
            , max_pos = {
                n: definition.start[1]-definition.movement[0]
                , e: definition.start[0]+definition.movement[1]
                , s: definition.start[1] + definition.movement[2]
                , w: definition.start[0]- definition.movement[3]
            }
            , step = definition.step || 5
            , top = +(definition.dom.style.top.split('px')[0])
            , left = +(definition.dom.style.left.split('px')[0]);

            console.log(max_pos);

        switch(dir) {
            case 0:
                console.log(definition,'north');
                if((top-step) > max_pos.n && top-step >= 0) {
                    definition.dom.style.top = (top-step)+'px';
                }
                break;

            case 1:
                console.log(definition,'east');
                if((left+step) < max_pos.e) {
                    definition.dom.style.left = (left+step)+'px';
                }
                break;

            case 2:
                console.log(definition,'south');
                if((top+step) < max_pos.s) {
                    definition.dom.style.top = (top+step)+'px';
                }
                break;

            case 3:
                console.log(definition,'west');
                if((left-step) > max_pos.w && left-step >= 0) {
                    definition.dom.style.left = (left-step)+'px';
                }
                break;
        }
    }
}, sandbox.module));


var rat = sandbox.request_module('mob').create(
    'Rat', 'r', util.extend({
        movement: [10,10,10,10]
        , start: [35,165]
        , speed: 0.5
    }, sandbox.request_module('mob').definition)
);


/**
 * Basically, if these pass you know that everything is working. If you get ANY
 * errors during testing, it could be a fault of: nobi, dom, util or sandbox.
 */
var inventory = util.clone(sandbox.request_module('window'));
inventory.create({
    title: 'inventory window'
    , mode: 'landscape'
    , keycode: util.KEYS.I
}).render(false);


var skills = util.clone(sandbox.request_module('window'));
skills.create({
    title: 'skills window'
    , keycode: util.KEYS.K
}).render();

var help = util.clone(sandbox.request_module('window'));
help.create({
    title: 'help window'
    , keycode: util.KEYS.FORWARD_SLASH
    , shiftKey: true
}).render();


var test = util.clone(sandbox.request_module('window'));
test.create({
    title: 'test window'
    , keycode: util.KEYS.FORWARD_SLASH
}).render();

/*
// socket objects!
socket.on('connect', function(){
    nobi.notify('socket-connection')
});

socket.on('message', function(msg){
    nobi.notify('socket-message',msg);
});

socket.on('disconnect', function(){
    nobi.notify('socket-disconnect');
});*/

// async tests
// async.get
async.get({url: 'index.php'}, function(data) {

    console.log(JSON.parse(data));
});

async.post({url: 'index.php', data: {field_name: 'field_value', field_name_2: 'field_value_2'}}, function(data) {
    console.log(JSON.parse(data));
});