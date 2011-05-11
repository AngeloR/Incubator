var notes        // list of all notes
    , note;      // the definition of a single note

sandbox.register_module('ns',util.extend({
    title: 'Note System'
    , description: 'Manages all notes'
    , base_url: 'index.php/?/'
    , notes: {
        /**
         * @param array _list a list of all the notes
         */
        _list: []
        
        /**
         * Updates our internal listing of notes
         * 
         * @param array data the data that we will be putting into our note_list.
         */
        , update_note_list: function(data) {
            for(var i = 0, l = data.length; i < l; ++i) {
                this.notes._list.push(data[i]);
            }
        }
        /**
         * Gets a list of notes based on from and to. If from and to are NOT
         * defined, then all notes are returned.
         *
         * @param int from  lower limit for note list
         * @param int to    upper limit for note list
         */
        , list: function(from,to) {
            from = from || 0;
            to = to || +new Date();

            async.get({url: base_url+'notes', data: {from: from, to: to}}, this.notes.update_note_list);
        }

        /**
         * Adds a note to the database and then pushes it to the _list
         *
         */
        , add: function() {

        }
    }
    , initialize: function() {
        this.notes.list();
    }
}, sandbox.module));
