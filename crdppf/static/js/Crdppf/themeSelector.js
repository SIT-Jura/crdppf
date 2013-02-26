﻿Ext.namespace('Crdppf');

// create layer tree and append nodes & subnodes to it
Crdppf.ThemeSelector = function createThemeSelector () {
    this.makeThemeSelector = makeThemeSelector;
}

var makeThemeSelector = function makeThemeSelector(){

    var myReader = new Ext.data.JsonReader({
        idProperty: 'id',
        root: 'themes',
        //Ext.data.DataReader.messageProperty: 'msg',
        fields: [
            {name: 'name', mapping: 'name'},
            {name: 'image', mapping: 'image'}
        ]
    });
    var myStore = new Ext.data.Store({
        reader: myReader
    });

    myStore.loadData(Crdppf.layerListFr);
    console.log(myStore)
    
    testUrl = '<img src=' + Crdppf.imagesDir +'sitn_banniere_final_right.png' + '></img>';
    var listView = new Ext.list.ListView({
        id: 'themeListView',
        store: myStore,
        autoWidth:true,
        hideHeaders: true,
        expanded: true,
        autoScroll:true,
        singleSelect : true,
        emptyText: 'No images to display',
        reserveScrollOffset: true,
        // selectedClass: 'clsListViewItemSelected',
        // overClass: 'listViewOverClass',
        columns: [
            {header:'icon',
             width: 0.15,
             dataIndex: 'image',
             tpl: '<img src=' + Crdppf.imagesDir + '/themes/{image}'+ ' width=50 height=25></img>'
            },
            {
            header: 'Thèmes',
            width: 0.85,
            dataIndex: 'name',
            tpl: '<p style="padding-top:6px">{name}</p>'
            }
            ],
        listeners:{
            click: function(view, index, node, e){
                console.log(layerTree)
                layerTree.getRootNode().cascade(function(n) {
                    var ui = n.getUI();
                    ui.toggleCheck(false);
                });
                layerTree.getNodeById(myStore.getAt(index).id).getUI().toggleCheck(true)
            }
        }
    });

    var themePanel = new Ext.Panel({
        id:'images-view',
        autoWidth:true,
        autoHeight: true,
        collapsible:true,
        autoScroll:false,
        animate:true,
        layout:'fit',
        title:'Sélection des thèmes',
        items: listView
    });
    // little bit of feedback
    // listView.on('selectionchange', function(view, nodes){
        // var l = nodes.length;
        // var s = l != 1 ? 's' : '';
        // themePanel.setTitle('Simple ListView ('+l+' item'+s+' selected)');
    // });
    
    return themePanel;
}