$(document).ready(function() {
	$("#states_table .delete_state").click( function() {
      if( $(this).parents('tbody').children('tr').length == 2 ){
      	$("#notice").text("you must keep atleast one state")
      	return false;
      }
	});	
});