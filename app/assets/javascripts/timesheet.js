


TimeSheet = function(){

};

TimeSheet.ready = function(){

    //var rows = $("table#timesheet tr");
    //console.log(rows);
    //for( var i =0; i < rows.length; i++) {
        $("table#timesheet tr").dblclick(TimeSheet.activateRow);//function () {
            TimeSheet.activateRow();
            //TimeSheet.createNewRow();
        //});
    //$("td").attr('contenteditable' ,'false');
   /* var entries = $("td")
    for( var i =0; i < entries.length; i++)
    {
        if( $(entries[i]).html() == "")  {
            //$(entries[i]).html("hjhjh");
        }
    }
    */


};

TimeSheet.createNewRow = function(item){
    var newrow = $(item).clone(true);
    $($(newrow).find("td")[0]).text("");
    $(item).after($(newrow));
    $(item).attr("class" , "");
};

TimeSheet.activateRow = function(){
    var childs = $(this).find('td');
    $(childs[1]).attr('contenteditable', 'true');
    $(childs[2]).attr('contenteditable', 'true');
    $(childs).attr('keyup', TimeSheet.changed )

    if( $(this).attr("class") == "last_row")
        TimeSheet.createNewRow(this);


};

TimeSheet.changed = function(){
  $("#submit").css('display' , 'block')
};

$(document).ready(TimeSheet.ready);
$(document).on('page:load', TimeSheet.ready);

