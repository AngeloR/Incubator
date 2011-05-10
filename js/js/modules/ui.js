sandbox.register_module('ui', util.extend({
    title: 'User Interface Module'
    , description: 'Handles UI elements'
    , obj: undefined
    , inside_object: undefined
    , create_holders: function(view) {
        
        var children        // holds all children
            , obj
            , div           // outer div - this is absolutely positioned
            , inner;        // inner div - this is relatively positioned so we can put elements inside

        if(!view.children) {
            view.children = [];
        }
        if(view.children!==undefined && !util.check.isArray(view.children)) {
            children = [view.children];
        }
        else {
            children = view.children;
        }

        view.dimensions = view.dimensions || [0,0];
        view.position = view.position || [0,0];

        div = document.createElement('div');
        inner = document.createElement('div');

        
        
        div.style.position = 'absolute';
        inner.style.width = view.dimensions[0]+'px';
        inner.style.height = view.dimensions[1]+'px';
        div.style.top = view.position[1]+'px';
        div.style.left = view.position[0]+'px';

        inner.className = view.view + ' '+(view.className || '');
        inner.style.position = 'relative';
        inner.innerHTML = view.content || '';
        inner.style.top = '0px';
        inner.style.left = '0px';

        if(view.id) {
            inner.setAttribute('id',view.id);
        }

        for(var i = 0, l = children.length; i < l; ++i) {
            obj = this.create_holders(children[i]);
            if(children[i].callbacks) {
                $.each(children[i].callbacks, function(event,callback) {
                    $(obj)[event](callback);
                });
            }
            inner.appendChild(obj);
        }
        div.appendChild(inner);
        this.completed = div;
        return div;
    }
    , completed: undefined
    , create: function(view) {
        this.create_holders(view);
        return this;
    }
    , attachTo: function(obj) {
        if(obj[0]==='#') {
            document.getElementById(obj).appendChild(this.completed);
        }
        else if(obj[0] === '.') {

        }
        else if(obj[0] === '!') {
            console.log('ui object!');
        }
        else {
            document.getElementsByTagName(obj)[0].appendChild(this.completed);
        }
    }
}, sandbox.module));



var ui = sandbox.request_module('ui');

ui.create({
    view: 'container', position: [0,0], dimensions: [200,400], anchor: 'top', className: 'container2', children: [
            {view: 'button', position: [97,374], dimensions: [28,16], id: 'Login', content: 'Login', callbacks: {
                    click: function() {
                        console.log('clicked login');
                    }
                }
            }
            , {view: 'button', position: [144,374], dimensions: [36,16], content: 'Logout', callbacks: {
                    click: function() {
                        console.log('clicked logout');
                    }
                }
            }
        ]}
).attachTo('body');