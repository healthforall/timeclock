TimeSheetCom = function(){

};

TimeSheetCom.getTimeSheet = function(){
    var entries = $("table.vblu tbody tr");
    days = {};
    for ( var i =0; i < entries.length; i++) {
        var entry = $(entries[i]);
        var day   = parseInt($(entry).attr("class").match(/\d+/g)[0] - 1 );
        if( !(day in days) ){
         days[day] = [];
        }
        var data  = $(entry).find("td");
        var inandout = { "in" : $(data[1]).text() , "out" : $(data[2]).text()}
        if( inandout['in'] || inandout['out']){
            days[day].push(inandout);

        }

    }
    timesheet = {};
    timesheet['days'] = days;
    console.log(JSON.stringify(timesheet));
    return timesheet
};

TimeSheetCom.sendChanges = function(){

    timesheet= TimeSheetCom.getTimeSheet();
    $.ajax({
        type: 'POST',
        data: JSON.stringify(timesheet),
        url: document.location.pathname.replace("show" , "update"),
        timeout: 5000,
        success: function(data, requestStatus, xhrObj)  { TimeSheetCom.success( data, requestStatus, xhrObj);  } ,
        error: function (xhrObj, textStatus, exception) { TimeSheetCom.error(xhrObj , textStatus, exception); }
    });
};

TimeSheetCom.success = function( data , requestStatus, xhrObj){
    //document.getElementById("timesheet").innerHTML = data;
    //TimeSheet.ready();
    location.reload();
};

TimeSheetCom.error = function( xhrObj, textStatus , exception){
    console.log(textStatus);
};