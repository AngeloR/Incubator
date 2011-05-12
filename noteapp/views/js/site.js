/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function site_ui() {
    $('#wrapper').css('top',$(window).height()/2-$('#wrapper').outerHeight()/2);
    $('#wrapper').css('left',$(window).width()/2-$('#wrapper').outerWidth()/2);
}
site_ui();
$('#logo').css('top',$('#wrapper').outerHeight()/2 - 64);
$(window).resize(site_ui);

$('#password').iphonePassword({
    duration: 1000
    , mask: '*'
});

$('#login').click(function(e){
    if($('#email').val() === '') {
        $('#notifications').html('Whoops, you forgot to enter an email address.');
        $('#notifications').show();
        $('#email').focus();
    }
    else if($('#password').val() === '') {
        $('#notifications').html('Whoops, you forgot to enter your password.');
        $('#notifications').show();
        $('#email').focus();
    }
    else {
        var info = {
            email: $('#email').val()
            , password: $('#password').val()
        };

        async.post({url: 'index.php/?/login', data: info}, function(res) {
            try {
                res = JSON.parse(res);
                if(res.status === 'success') {
                    window.location = 'index.php/?/app';
                }
                else {
                    $('#notifications').html(res.data);
                    $('#notifications').show();
                }
            }
            catch(e) {
                console.log(e,res);
            }
        });
    }
    return false;
});

$('#signup').click(function(e){
    if($('#email').val() === '') {
        $('#notifications').html('Whoops, you forgot to enter an email address.');
        $('#notifications').show();
        $('#email').focus();
    }
    else if($('#password').val() === '') {
        $('#notifications').html('Whoops, you forgot to enter your password.');
        $('#notifications').show();
        $('#email').focus();
    }
    else {
        var info = {
            email: $('#email').val()
            , password: $('#password').val()
        };

        async.post({url: 'index.php/?/signup', data: info}, function(res){
            try {
                res = JSON.parse(res);

                if(res.status === 'success') {
                    window.location = 'index.php/?/app';
                }
                else {
                    $('#notifications').html(res.data);
                    $('#notifications').show();
                }
            }
            catch(e) {
                console.log(e,res);
            }
        });
    }
    return false;
});