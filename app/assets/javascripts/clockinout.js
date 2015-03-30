/**
 * Created by jtgoen on 3/21/15.
 */
function ClockInOut(){

}

var ready;
/*
ClockInOut.ready = function() {
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
        ClockInOut.toggle();
        ClockInOut.sendClockInOutMessage(true);
    })
    $("#clockout").click(function() {
        ClockInOut.toggle();
        ClockInOut.sendClockInOutMessage(false);
    });
};
*/
ClockInOut.click_in = function() {
    ClockInOut.toggle();
    ClockInOut.sendClockInOutMessage(true);
};

ClockInOut.click_out = function(){
    ClockInOut.toggle();
    ClockInOut.sendClockInOutMessage(false);
};

ClockInOut.sendClockInOutMessage = function(checkin){
    $.ajax({type: 'POST',
            url: "/employees/clockin/"+checkin,
            timeout: 5000,
            success: function(data, requestStatus, xhrObj){
            },
            error: function (xhrObj, textStatus, exception) {}})
};

ClockInOut.getInsAndOuts = function(){
    $.ajax({type: 'GET',
        url: "/employees/clockin/"+checkin,
        timeout: 5000,
        success: function(data, requestStatus, xhrObj){},
        error: function (xhrObj, textStatus, exception) {}})
};

ClockInOut.toggle = function(){
   if ($("#clockin").css("display") == "none") {
        $("#clockin").show();
        $("#clockout").hide();
    }
    else{
        $("#clockin").hide();
        $("#clockout").show();
    }
}
//$(document).ready(ClockInOut.ready);
//$(document).on('page:load', ClockInOut.ready);
