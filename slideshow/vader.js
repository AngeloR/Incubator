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
            , title: 'sample module'
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
        , I: 73
        , J: 74
        , K: 75
    }
};

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
            return ;
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
        // bind to internal message received
        nobi.bind('chat-message-received', this.displayMessage, this)

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
    title: 'wmd'
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