/**
 * Created by jtgoen on 3/21/15.
 */
function ClockInOut(){

}

var ready;

ClockInOut.ready = function() {
    console.log("HI");
    if(true)
        $("#clockout").css("display" , "block");
    if ($('#clockinquestionmark').text() == "true"){
        $("#clockin").css("display" , "none");
        $("#clockout").css("display" , "block");
    }
    else {
        //alert($('#inorout').text());
        $("#clockout").css("display" , "none");
        $("#clockin").css("display" , "block");
    }
    $("#clockin").click(function() {
        $("#clockin").hide();
        $("#clockout").show();
        ClockInOut.sendClockInOutMessage(true);
    })
    $("#clockout").click(function() {
        $("#clockout").hide();
        $("#clockin").show();
        ClockInOut.sendClockInOutMessage(false);
    });
};

ClockInOut.sendClockInOutMessage = function(checkin){
    $.ajax({type: 'POST',
            url: "/employees/clockin/"+checkin,
            timeout: 5000,
            success: function(data, requestStatus, xhrObj){},
            error: function (xhrObj, textStatus, exception) {}})
};

ClockInOut.getInsAndOuts = function(){
    $.ajax({type: 'GET',
        url: "/employees/clockin/"+checkin,
        timeout: 5000,
        success: function(data, requestStatus, xhrObj){},
        error: function (xhrObj, textStatus, exception) {}})
};

$(document).ready(ClockInOut.ready);
$(document).on('page:load', ClockInOut.ready);
