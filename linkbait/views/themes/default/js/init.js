var APP_MODE = 0;           // 0 for debug, 1 for production

window.console = (!window.console || APP_MODE)?{
    log: function() {}
    , error: function() {}
}:window.console;