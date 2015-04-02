/**
 * Created by jtgoen on 3/21/15.
 */
function ClockInOut(){

}

var ready;
ClockInOut.checkedin = false;
ClockInOut.ready = function() {

    if ($('#clockinquestionmark').text() == "true"){
        ClockInOut.checkedin = true;
        $("#clockin").text("Clock Out");
    }
    else {
        ClockInOut.checkedin = false;
        $("#clockin").text("Clock In");
    }
    $("#clockin").click(function() {
        ClockInOut.sendClockInOutMessage(!ClockInOut.checkedin);
    })
};


ClockInOut.sendClockInOutMessage = function(checkin){
    $.ajax({type: 'POST',
            url: "/employees/clockin/"+checkin,
            timeout: 5000,
            success: function(data, requestStatus, xhrObj){
                location.reload(); //TODO THIS IS ENIFICENT
                //ClockInOut.toggle();
            },
            error: function (xhrObj, textStatus, exception) { alert("Failure occurred when sending message to server.")}})
};

ClockInOut.getInsAndOuts = function(){
    $.ajax({type: 'GET',
        url: "/employees/clockin/"+checkin,
        timeout: 5000,
        success: function(data, requestStatus, xhrObj){},
        error: function (xhrObj, textStatus, exception) {}})
};

ClockInOut.toggle = function(){
   if (ClockInOut.checkedin) {
        $("#clockin").text("Clock In");
        ClockInOut.checkedin = false;
    }
    else{
       $("#clockin").text("Clock Out");
       ClockInOut.checkedin = true;
    }
}

$(document).ready(ClockInOut.ready);
$(document).on('page:load', ClockInOut.ready);
