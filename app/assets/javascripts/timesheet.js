


TimeSheet = function(){

};

TimeSheet.ready = function(){
    $("table#timesheet tr.last_row").dblclick( TimeSheet.activateLastRow );
};

TimeSheet.activateLastRow = function(){
    console.log(this);
    $(this).css('background-color' , 'blue');
    $("div.table_div").attr('contenteditable' ,'true');
    console.log($("div.table_div"))

};

$(document).ready(TimeSheet.ready);
$(document).on('page:load', TimeSheet.ready);

