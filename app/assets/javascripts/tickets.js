$(document).ready(function(){
	$("#upload_file").hide();
	if( $('#searched_tickets_table tr').length == 1 ) {
	  $('#notice').html('no tickets for this search');
	}

	$("#attach_file_anchor").click( function() {
		$(this).parent('div').remove();
		$("#upload_file").show();
	})
});