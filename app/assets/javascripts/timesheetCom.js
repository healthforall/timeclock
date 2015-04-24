TimeSheetCom = function(){

};


TimeSheetCom.getTimeSheet = function(){
    var entries = $("tbody tr");
    var numdays    = $("tbody tr.last_row").length;
    var days = {};
    var timesheet = {};
    for ( var i =0; i < numdays; i ++) {
        days[i] = [];
    }

    for ( var i =0; i < entries.length; i++) {

        var entry = $(entries[i]);
        var nums  = $(entry).attr("class").match(/\d+/g);;
        var day   = parseInt(nums[0]) -1;
        var data  = $(entry).find("td");
        var inandout = { "in" : $(data[1]).text() , "out" : $(data[2]).text()}
        if( inandout['in'] || inandout['out'])
            days[day].push(inandout)
    }
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