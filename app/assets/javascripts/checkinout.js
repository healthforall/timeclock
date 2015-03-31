/**
 * Created by jtgoen on 3/21/15.
 */
function ClockInOut(){

}

var ready;

ready = function() {
    $("#clockout").hide();
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

$(document).ready(ready);
$(document).on('page:load', ready);
