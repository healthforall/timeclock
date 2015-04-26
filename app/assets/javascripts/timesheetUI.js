


TimeSheet = function(){

};

TimeSheet.check_charcount = function( elem, e )
{
    if( ( (!TimeSheet.acceptableKeys(e.which)) && $(elem).text().length > 8)   )
    {
        e.preventDefault();
        return false;
    }
    return true;
};

TimeSheet.acceptableKeys = function(e){
    if( e == 8 ||
       e == 37 || e == 38 ||
       e == 39 || e == 40 )
        return true
    else
        return false;
};

TimeSheet.submitChanges = function(){
    var badtime = false;
    var entries = $("table.vblu tbody tr")
    var day = undefined;
    var firstDanglingIn = true;
    var firstDanglinInLoc = undefined;
    for (var i=0; i < entries.length; ++i){
        var data  = $(entries[i]).find("td");
        if( $(data[1]).text() != "")
            day = $(data[1]).text() + "/" + (new Date(Date.now()).getFullYear()) + "/"

        var inandout = {
            "in" : new Date(Date.parse( day +$(data[2]).text())),
            "out" : new Date(Date.parse(day +$(data[3]).text()))};
        if (inandout.in > inandout.out || $(data[2]).text() == '' || $(data[3]).text() == '') //Detect Errors
        {
            //Lonely In
            if ($(data[2]).text() != ''){
                if((((new Date(day)).getDate()) == new Date(Date.now()).getDate() && firstDanglingIn)) {
                    firstDanglingIn = false;
                    firstDanglinInLoc = data[3];
                }
                else
                {
                    if( ((new Date(day)).getDate()) == new Date(Date.now()).getDate() )
                    {
                        $(firstDanglinInLoc).toggleClass("error");
                    }
                    else {
                        $(data[3]).toggleClass('error')
                        $(data[4]).toggleClass('error')
                    }
                    badtime = true;
                }

            }
            //Danglin Out
            if ($(data[3]).text() != '') {
                $(data[2]).toggleClass('error')
                badtime = true;
            }
        }
        else{
            $(entries[i]).css("background-color", "");
        }
    }
    if (!badtime){
        TimeSheetCom.sendChanges();
        $("#submit").css("display" , "none");
    }
    else{
        alert("There were time conflicts or missing fields (marked in red). Please fix these issues and resubmit.");
    }
};

TimeSheet.ready = function(){
    $("#submit").click(TimeSheet.submitChanges);
    //$("table.vblu tr").dblclick(TimeSheet.doubleClickRow);
    $.contextMenu({
        selector: 'table.vblu tr',
        callback: function(key) {
            TimeSheet.createNewRow(key, this);
        },
        items: {
            "above": {name: "Add Row Above"},
            "below": {name: "Add Row Below"}
        }
    });
    $("table.vblu").find("tbody tr").click(function(e){
       var row = this;
       TimeSheet.showDeleteButton(row);
    });
    $("table.vblu").find("tbody tr").mouseleave(function(e){
        var row = this;
        TimeSheet.hideDeleteButton(row);
    });
    $("td[contenteditable = 'true']").keydown(function(e){
        var elem = this;
        var change = TimeSheet.check_charcount(elem , e);
        TimeSheet.changed(change , e);

    }); //THis is importatnt to me for reasons...
};

TimeSheet.showDeleteButton = function(row){
    var rowid = $(row).attr("class");
    if($("#delete").length == 0) {
        var r = $('<input type="button" id ="delete" value="delete""/>');
        $(r).click(function(){TimeSheet.deleteRow(rowid); TimeSheet.changed(true)});
        var col = row.insertCell(-1);
        $(col).append(r);
    }
};


TimeSheet.deleteRow = function(type){
    if(type == '')
        return;
    var row = $("."+type);
    var col = $(row).find("td")[1];
    if($(col).text() != '') {
        var next = $(row).next()[0];
        $($(next).find("td")[1]).text( $(col).text() );
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

TimeSheet.createNewRow = function(choice, item){
    TimeSheet.hideDeleteButton(item);
    var day = $(item).attr("class").match(/\d+/g)[0];
    var prevrow = $(item).prev()[0];
    var nums = [];
    if(prevrow){
        nums = $(prevrow).attr('class').match(/\d+/g);
        /* This might be the direction to go in to prevent more than one empty row
        cols = $(prevrow).find("td");
        if( $(cols[1]).text() =='' && $(cols[2]).text() == '')
        {

        }

        */
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
    $($(newrow).find("td")[1]).text("");
    $(newrow).removeClass("context-menu-active");

    if (choice == 'above'){ //Copy current row's times to a new row below and blank out the current row.
        $($(newrow).find("td")[2]).text($($(item).find("td")[2]).text());
        $($(newrow).find("td")[3]).text($($(item).find("td")[3]).text());
        $($(item).find("td")[2]).text("");
        $($(item).find("td")[3]).text("");
        $(item).after($(newrow));
    }
    else { //Add a blank row below the current row
        $($(newrow).find("td")[2]).text("");
        $($(newrow).find("td")[3]).text("");
        $(item).after($(newrow));
    }

    $(item).attr("class" , "Day" + nums[0] + "Row"+ (parseInt(nums[1])+1));
};

TimeSheet.doubleClickRow = function(){
    var childs = $(this).find('td');
    //$(childs[1]).attr('contenteditable', 'true');
    //$(childs[2]).attr('contenteditable', 'true');

    if( $(this).attr("class").indexOf("last_row") > -1)
        TimeSheet.createNewRow(this);

};

TimeSheet.changed = function(change ,e ){
    if(e != 0 && e !=1 && e != 2 && change) {
        $("#submit").css('display', 'inline-block');
    }

};


TimeSheet.changePeriod = function() {
    var regexp = /\/employees\/\d+/gi;
    var path = window.location.pathname.match(regexp)[0] + "/payperiods/";
    path += document.getElementById("periodSelector").value;
    window.location.href = path;
}


$(document).ready(TimeSheet.ready);
$(document).on('page:load', TimeSheet.ready);

