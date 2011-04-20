var hitbox, coords,npc,player = {}, screen;
screen = (function(){
    return {
        place: function(obj) {
            var d = document.createElement('div');
            d.innerHTML = obj.representation;
            d.style.position = 'absolute';
            d.style.top = obj.location.x;
            d.style.left = obj.location.y;
            document.getElementsByTagName('body')[0].appendChild(d);
        }
    };
})();

player = {
    location: {
        x: 100
        , y: 117
    }
    , representation: 'x'
};
player.hitbox = (function(){
    var style = 'rect'  //ignored for now, only rect is supported
        , size = {
            x: 16
            , y: 16
        };
        
    return {
        collision: function(obj) {
            switch(style) {
                default:
                    var size_x = size.x/2
                        , size_y = size.y/2;
                    return !(
                        (obj.location.x-size_x) > (player.location.x+size_x)
                        || (obj.location.x+size_x) < (player.location.x-size_x)
                        || (obj.location.y-size_y) > (player.location.y+size_y)
                        || (obj.location.y+size_y) < (player.location.y-size_y)
                    );
                    break;
            }
        }
    };
})();

npc = {
    location: {
        x: 100
        , y: 100
    }
    , representation: 'o'
}

screen.place(player);
screen.place(npc);


if(player.hitbox.collision(npc)) {
    console.log('intersection');
}
