


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
    var dailyInAndOuts = [];
    for (var i=0; i < entries.length; ++i){
        var data  = $(entries[i]).find("td");



        function compareEntries(a,b) {
            if (a.time < b.time){
                return -1;
            }
            if (a.time > b.time){
                return 1;
            }
            return 0;
        }

        if( $(data[0]).text() != ""){
            day = $(data[0]).text() + "/" + (new Date(Date.now()).getFullYear()) + "/";
            var overlappingTimes = [];
            for (var j=0; j < dailyInAndOuts.length; ++j){
                var inandoutToCheck = dailyInAndOuts[j];
                for (var k=0; k < dailyInAndOuts.length; ++k){
                    if (k==j){
                    }
                    else{
                        var firstCheckBool = inandoutToCheck.inandout.in < dailyInAndOuts[k].inandout.out;
                        var secondCheckBool = dailyInAndOuts[k].inandout.in < inandoutToCheck.inandout.out;
                        var overlap = firstCheckBool && secondCheckBool;
                        if (overlap){
                            overlappingTimes[inandoutToCheck.row] = true;
                            overlappingTimes[dailyInAndOuts[k].row] = true;
                            badtime = true;
                        }
                    }
                }
            }
            for (var time=0; time < overlappingTimes.length; ++time){
                if (overlappingTimes[time] == true){
                    $($(entries[time]).find("td")[1]).addClass("overlap");
                    $($(entries[time]).find("td")[2]).addClass("overlap");
                }
                else{
                    $($(entries[time]).find("td")[1]).removeClass("overlap");
                    $($(entries[time]).find("td")[2]).removeClass("overlap");
                }
            }
        }

        var inandout = {
            "in" : new Date(Date.parse( day +$(data[1]).text())),
            "out" : new Date(Date.parse(day +$(data[2]).text()))
        };

        var dailyInAndOut ={
            "inandout" : inandout,
            "row" : i
        };

        if($(data[1]).text() != '' || $(data[2]).text() != ''){
            dailyInAndOuts.push(dailyInAndOut);
        }

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
                        $(firstDanglinInLoc).addClass("error");
                    }
                    else {
                        $(data[2]).addClass('error');
                    }
                    badtime = true;
                }

            }
            else{
                $(entries[i]).removeClass("error");
            }
            //Danglin Out
            if ($(data[2]).text() != '') {
                $(data[1]).addClass('error');
                badtime = true;
            }
            else{
                $(entries[i]).removeClass("error");
            }
        }
        else{
            $(entries[i]).removeClass("error");
        }
    }
    if (!badtime){
        TimeSheetCom.sendChanges();
        $("#submit").css("display" , "none");
        $("#revert").css("display" , "none");
    }
    else{
        alert("There were time conflicts/missing fields (marked in red), or there was an overlap (marked in yellow). Please fix these issues and resubmit.");
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

    $("td[contenteditable = 'true']").inputmask({
        mask: "h:s t\\m",
        placeholder: "hh:mm xm",
        alias: "datetime",
        hourFormat: "12"
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
    var newrow  = $(item).clone();
    $(newrow).removeClass("context-menu-active");
    $($(newrow).find("td")[1]).text("");
    $($(newrow).find("td")[2]).text("");

    if (choice == 'above'){ //Add blank row above current row
        $($(item).find("td")[0]).text("");
        $(item).before($(newrow));
    }
    else { //Add a blank row below the current row
        $($(newrow).find("td")[0]).text("");
        $(item).after($(newrow));
    }
    TimeSheet.ready();
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