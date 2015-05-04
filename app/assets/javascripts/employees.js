Employees = function() {

}

Employees.massExport = function() {
  if(document.getElementById("nameSelector").value != "All") {
    var path = window.location.pathname + "/";
    path += document.getElementById("nameSelector").value;
    path += "/payperiods/";
    path += document.getElementById("periodSelector").value;
    path += ".xls";
    window.location.href = path;
  }
  else {
    var path = "massexport/payperiods/";
    path += document.getElementById("periodSelector").value;
    window.location.href = path;
  }
}
