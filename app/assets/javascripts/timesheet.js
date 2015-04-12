


TimeSheet = function(){

};

TimeSheet.check_charcount = function( elem, e )
{
    if(e.which != 8 && $(elem).text().length > 4)
    {
        e.preventDefault();
        return false;
    }
    return true;
};

TimeSheet.ready = function(){
    $("table.timesheet tr").dblclick(TimeSheet.doubleClickRow);
    $("td").attr('contenteditable' ,'false');
    $("table.timesheet").find("tbody tr").click(function(e){
       var row = this;
       TimeSheet.showDeleteButton(row);
    });
    $("table.timesheet").find("tbody tr").mouseleave(function(e){
        var row = this;
        TimeSheet.hideDeleteButton(row);
    });
    $('td').keydown(function(e){
        var elem = this;
        var change = TimeSheet.check_charcount(elem , e);
        TimeSheet.changed(change , e);

    }); //THis is importatnt to me for reasons...
};

TimeSheet.showDeleteButton = function(row){
    var rowid = $(row).attr("class");
    if($("#delete").length == 0) {
        var r = $('<input type="button" id ="delete" value="delete""/>');
        $(r).click(function(){TimeSheet.deleteRow(rowid);});
        var col = row.insertCell(-1);
        $(col).append(r);
    }
};


TimeSheet.deleteRow = function(type){
    if(type == '')
        return;
    var row = $("."+type);
    var col = $(row).find("td")[0];
    if($(col).text() != '') {
        var next = $(row).next()[0];
        $($(next).find("td")[0]).text( $(col).text() );
    }
    var afters = $("." + type).next()
    var day = type.match(/\d+/g)[0];
    for( var i =0; i < afters.length; i++)
    {
        var nums = $(afters[i]).attr("class").match(/\d+/g);
        if( nums[0] == day && nums[1] )
        {
            $(afters[i]).attr("class" , "Day" + nums[0] +"Row" + (parseInt(nums[1])-1));
        }
        else
        {
            break;
        }

    }
    $(row).remove();

};
TimeSheet.hideDeleteButton = function(row){
    if($("#delete").length!=0) {
        row.deleteCell(-1);
    }

}

TimeSheet.createNewRow = function(item){
    TimeSheet.hideDeleteButton(item);
    var day = $(item).attr("class").match(/\d+/g)[0];
    var prevrow = $(item).prev()[0];
    var nums = [];
    if(prevrow){
        nums = $(prevrow).attr('class').match(/\d+/g);
        if( nums[0] != day)
        {
            nums[0] = day;
            nums[1] = 0;
        }

    }
    else {
        nums = [day , 0];
    }
    var newrow  = $(item).clone(true);
    $($(newrow).find("td")[0]).text("");
    $(item).after($(newrow));
    $(item).attr("class" , "Day" + nums[0] + "Row"+ (parseInt(nums[1])+1));
};

TimeSheet.doubleClickRow = function(){
    var childs = $(this).find('td');
    $(childs[1]).attr('contenteditable', 'true');
    $(childs[2]).attr('contenteditable', 'true');

    if( $(this).attr("class").indexOf("last_row") > -1)
        TimeSheet.createNewRow(this);


};

TimeSheet.changed = function(change ,e ){
    if(e != 0 && e !=1 && e != 2 && change)
     $("#submit").css('display' , 'block')
};

$(document).ready(TimeSheet.ready);
$(document).on('page:load', TimeSheet.ready);

