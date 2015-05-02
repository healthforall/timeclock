


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
        if( $(data[0]).text() != "")
            day = $(data[0]).text() + "/" + (new Date(Date.now()).getFullYear()) + "/"

        var inandout = {
            "in" : new Date(Date.parse( day +$(data[1]).text())),
            "out" : new Date(Date.parse(day +$(data[2]).text()))};
        if (inandout.in > inandout.out || $(data[1]).text() == '' || $(data[2]).text() == '') //Detect Errors
        {
            //Lonely In
            if ($(data[1]).text() != ''){
                if((((new Date(day)).getDate()) == new Date(Date.now()).getDate() && firstDanglingIn)) {
                    firstDanglingIn = false;
                    firstDanglinInLoc = data[2];
                }
                else
                {
                    if( ((new Date(day)).getDate()) == new Date(Date.now()).getDate() )
                    {
                        $(firstDanglinInLoc).toggleClass("error");
                    }
                    else {
                        $(data[2]).toggleClass('error')
                        $(data[2]).toggleClass('error')
                    }
                    badtime = true;
                }

            }
            //Danglin Out
            if ($(data[2]).text() != '') {
                $(data[1]).toggleClass('error')
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
        $("#revert").css("display" , "none");
    }
    else{
        alert("There were time conflicts or missing fields (marked in red). Please fix these issues and resubmit.");
    }
};

TimeSheet.revertChanges = function(){
    location.reload();
    $("#clockin").css('display', 'inline-block');
    $("#submit").css('display', 'none');
    $("#revert").css('display', 'none');
};

TimeSheet.ready = function(){
    $("#submit").click(TimeSheet.submitChanges);
    $("#revert").click(TimeSheet.revertChanges);
    $.contextMenu({
        selector: 'table.vblu tr',
        callback: function(key) {
            if (key == 'delete'){
                TimeSheet.deleteRow();
            }
            TimeSheet.createNewRow(key, this);
        },
        items: {
            "above": {
                name: "Add Row Above",
                callback: function(key){TimeSheet.createNewRow(key, this);}},
            "below": {
                name: "Add Row Below",
                callback: function(key){TimeSheet.createNewRow(key, this);}},
            "delete": {
                name: "Delete Row",
                callback: function(){
                    TimeSheet.deleteRow(this);
                    }}
            /*adding another class to the tr may cause this to break
             it's needed because the context menu adds a new class to the selected tr
             that causes the type check in delete to fail*/
        }
    });
    $("td[contenteditable = 'true']").keydown(function(e){
        var elem = this;
        var change = TimeSheet.check_charcount(elem , e);
        TimeSheet.changed(change , e);
    }); //THis is importatnt to me for reasons...
};

TimeSheet.deleteRow = function(row){
    var next = $(row).next()[0];

    //context-menu-active is appended to row's class before delete is called, so need to only check first entry of class
    if($(row).attr("class").split(" ")[0] != $(next).attr("class")){
        console.log($(row).attr("class")+" "+$(next).attr("class"));
        $($(row).find("td")[1]).text('');
        $($(row).find("td")[2]).text('');
        return;
    }

    if($($(row).find("td")[0]).text() != '') {
        $($(next).find("td")[0]).text($($(row).find("td")[0]).text());
    }

    //FIXME if had a non-empty td[1], make the next row have one too (get parent and then get next child?)
    $(row).remove();
    TimeSheet.changed(true);
};

TimeSheet.createNewRow = function(choice, item){
    var newrow  = $(item).clone(true);
    $($(newrow).find("td")[0]).text("");
    $(newrow).removeClass("context-menu-active");

    if (choice == 'above'){ //Copy current row's times to a new row below and blank out the current row.
        $($(newrow).find("td")[1]).text($($(item).find("td")[1]).text());
        $($(newrow).find("td")[2]).text($($(item).find("td")[2]).text());
        $($(item).find("td")[1]).text("");
        $($(item).find("td")[2]).text("");
        $(item).after($(newrow));
    }
    else { //Add a blank row below the current row
        $($(newrow).find("td")[1]).text("");
        $($(newrow).find("td")[2]).text("");
        $(item).after($(newrow));
    }
};

TimeSheet.changed = function(change ,e ){
    if(e != 0 && e !=1 && e != 2 && change) {
        $("#clockin").css('display', 'none');
        $("#submit").css('display', 'inline-block');
        $("#revert").css('display', 'inline-block');
    }
};


TimeSheet.changePeriod = function() {
    var regexp = /\/employees\/\d+/gi;
    var path = window.location.pathname.match(regexp)[0] + "/payperiods/";
    path += document.getElementById("periodSelector").value;
    window.location.href = path;
};


$(document).ready(TimeSheet.ready);
$(document).on('page:load', TimeSheet.ready);