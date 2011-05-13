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
        , I: 73
        , J: 74
        , K: 75
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
                data += htmlentities(i)+'='+htmlentities(params[i])+'&';
            }
            return data.slice(0,data.length-1);
        }
        , get: function(opt,cb) {
            var request = xhr();
            opt = this.init(opt);
            var params = (opt.data.length > 0)?'?'+opt.data:'';

            request.open('GET',opt.url);
            request.onreadystatechange = function() {
                if(request.readyState === 4) {
                    return cb(request.responseText);
                }
            }
            request.send(htmlentities(params));
            
        }
        , post: function(opt,cb) {
            var request = xhr();
            opt = this.init(opt);

            request.open('POST', opt.url, opt.async);
            request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.onreadystatechange = function() {
                if(request.readyState === 4) {
                    return cb(request.responseText);
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
    , prepend: function(obj1,obj2) {
        $(obj1).prepend(obj2);
    }
    , append: function(obj1,obj2) {
        $(obj1).append(obj2);
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

function get_html_translation_table (table, quote_style) {
    // http://kevin.vanzonneveld.net
    // +   original by: Philip Peterson
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   bugfixed by: noname
    // +   bugfixed by: Alex
    // +   bugfixed by: Marco
    // +   bugfixed by: madipta
    // +   improved by: KELAN
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
    // +      input by: Frank Forte
    // +   bugfixed by: T.Wild
    // +      input by: Ratheous
    // %          note: It has been decided that we're not going to add global
    // %          note: dependencies to php.js, meaning the constants are not
    // %          note: real constants, but strings instead. Integers are also supported if someone
    // %          note: chooses to create the constants themselves.
    // *     example 1: get_html_translation_table('HTML_SPECIALCHARS');
    // *     returns 1: {'"': '&quot;', '&': '&amp;', '<': '&lt;', '>': '&gt;'}
    var entities = {},
        hash_map = {},
        decimal = 0,
        symbol = '';
    var constMappingTable = {},
        constMappingQuoteStyle = {};
    var useTable = {},
        useQuoteStyle = {};

    // Translate arguments
    constMappingTable[0] = 'HTML_SPECIALCHARS';
    constMappingTable[1] = 'HTML_ENTITIES';
    constMappingQuoteStyle[0] = 'ENT_NOQUOTES';
    constMappingQuoteStyle[2] = 'ENT_COMPAT';
    constMappingQuoteStyle[3] = 'ENT_QUOTES';

    useTable = !isNaN(table) ? constMappingTable[table] : table ? table.toUpperCase() : 'HTML_SPECIALCHARS';
    useQuoteStyle = !isNaN(quote_style) ? constMappingQuoteStyle[quote_style] : quote_style ? quote_style.toUpperCase() : 'ENT_COMPAT';

    if (useTable !== 'HTML_SPECIALCHARS' && useTable !== 'HTML_ENTITIES') {
        throw new Error("Table: " + useTable + ' not supported');
        // return false;
    }

    entities['38'] = '&amp;';
    if (useTable === 'HTML_ENTITIES') {
        entities['160'] = '&nbsp;';
        entities['161'] = '&iexcl;';
        entities['162'] = '&cent;';
        entities['163'] = '&pound;';
        entities['164'] = '&curren;';
        entities['165'] = '&yen;';
        entities['166'] = '&brvbar;';
        entities['167'] = '&sect;';
        entities['168'] = '&uml;';
        entities['169'] = '&copy;';
        entities['170'] = '&ordf;';
        entities['171'] = '&laquo;';
        entities['172'] = '&not;';
        entities['173'] = '&shy;';
        entities['174'] = '&reg;';
        entities['175'] = '&macr;';
        entities['176'] = '&deg;';
        entities['177'] = '&plusmn;';
        entities['178'] = '&sup2;';
        entities['179'] = '&sup3;';
        entities['180'] = '&acute;';
        entities['181'] = '&micro;';
        entities['182'] = '&para;';
        entities['183'] = '&middot;';
        entities['184'] = '&cedil;';
        entities['185'] = '&sup1;';
        entities['186'] = '&ordm;';
        entities['187'] = '&raquo;';
        entities['188'] = '&frac14;';
        entities['189'] = '&frac12;';
        entities['190'] = '&frac34;';
        entities['191'] = '&iquest;';
        entities['192'] = '&Agrave;';
        entities['193'] = '&Aacute;';
        entities['194'] = '&Acirc;';
        entities['195'] = '&Atilde;';
        entities['196'] = '&Auml;';
        entities['197'] = '&Aring;';
        entities['198'] = '&AElig;';
        entities['199'] = '&Ccedil;';
        entities['200'] = '&Egrave;';
        entities['201'] = '&Eacute;';
        entities['202'] = '&Ecirc;';
        entities['203'] = '&Euml;';
        entities['204'] = '&Igrave;';
        entities['205'] = '&Iacute;';
        entities['206'] = '&Icirc;';
        entities['207'] = '&Iuml;';
        entities['208'] = '&ETH;';
        entities['209'] = '&Ntilde;';
        entities['210'] = '&Ograve;';
        entities['211'] = '&Oacute;';
        entities['212'] = '&Ocirc;';
        entities['213'] = '&Otilde;';
        entities['214'] = '&Ouml;';
        entities['215'] = '&times;';
        entities['216'] = '&Oslash;';
        entities['217'] = '&Ugrave;';
        entities['218'] = '&Uacute;';
        entities['219'] = '&Ucirc;';
        entities['220'] = '&Uuml;';
        entities['221'] = '&Yacute;';
        entities['222'] = '&THORN;';
        entities['223'] = '&szlig;';
        entities['224'] = '&agrave;';
        entities['225'] = '&aacute;';
        entities['226'] = '&acirc;';
        entities['227'] = '&atilde;';
        entities['228'] = '&auml;';
        entities['229'] = '&aring;';
        entities['230'] = '&aelig;';
        entities['231'] = '&ccedil;';
        entities['232'] = '&egrave;';
        entities['233'] = '&eacute;';
        entities['234'] = '&ecirc;';
        entities['235'] = '&euml;';
        entities['236'] = '&igrave;';
        entities['237'] = '&iacute;';
        entities['238'] = '&icirc;';
        entities['239'] = '&iuml;';
        entities['240'] = '&eth;';
        entities['241'] = '&ntilde;';
        entities['242'] = '&ograve;';
        entities['243'] = '&oacute;';
        entities['244'] = '&ocirc;';
        entities['245'] = '&otilde;';
        entities['246'] = '&ouml;';
        entities['247'] = '&divide;';
        entities['248'] = '&oslash;';
        entities['249'] = '&ugrave;';
        entities['250'] = '&uacute;';
        entities['251'] = '&ucirc;';
        entities['252'] = '&uuml;';
        entities['253'] = '&yacute;';
        entities['254'] = '&thorn;';
        entities['255'] = '&yuml;';
    }

    if (useQuoteStyle !== 'ENT_NOQUOTES') {
        entities['34'] = '&quot;';
    }
    if (useQuoteStyle === 'ENT_QUOTES') {
        entities['39'] = '&#39;';
    }
    entities['60'] = '&lt;';
    entities['62'] = '&gt;';


    // ascii decimals to real symbols
    for (decimal in entities) {
        symbol = String.fromCharCode(decimal);
        hash_map[symbol] = entities[decimal];
    }

    return hash_map;
}

function htmlentities (string, quote_style, charset, double_encode) {
    // http://kevin.vanzonneveld.net
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: nobbler
    // +    tweaked by: Jack
    // +   bugfixed by: Onno Marsman
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +    bugfixed by: Brett Zamir (http://brett-zamir.me)
    // +      input by: Ratheous
    // +   improved by: Rafał Kukawski (http://blog.kukawski.pl)
    // -    depends on: get_html_translation_table
    // *     example 1: htmlentities('Kevin & van Zonneveld');
    // *     returns 1: 'Kevin &amp; van Zonneveld'
    // *     example 2: htmlentities("foo'bar","ENT_QUOTES");
    // *     returns 2: 'foo&#039;bar'
    var hash_map = {},
        symbol = '',
        entity = '',
        self = this;
    string += '';
    double_encode = !!double_encode || double_encode == null;

    if (false === (hash_map = this.get_html_translation_table('HTML_ENTITIES', quote_style))) {
        return false;
    }
    hash_map["'"] = '&#039;';

    if (double_encode) {
        for (symbol in hash_map) {
            entity = hash_map[symbol];
            string = string.split(symbol).join(entity);
        }
    } else {
        string = string.replace(/([\s\S]*?)(&(?:#\d+|#x[\da-f]+|[a-z][\da-z]*);|$)/g, function (ignore, text, entity) {
            return self.htmlentities(text, quote_style, charset) + entity;
        });
    }

    return string;
}