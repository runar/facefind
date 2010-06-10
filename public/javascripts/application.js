// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready( function() {
	
	$('#faceform').submit( function() {
		url = escape($('#id').val());
		furl = 'http://facebook.com/profile.php?id=';
		$.ajax({
			url: '/find.json',
			data: 'id=' + url,
			dataType: 'json',
			beforeSend: function() {
				$('#name').html('<img src="/images/loading.gif" alt="" />');
				$('#picture').empty();
				$('#link').empty();
			},
			success: function(msg) {
				$('#name').html('<a href="' + furl + msg.id + '">' + msg.name + '</a>');
				$('#picture').html('<a href="' + furl + msg.id + '"><img src="http://graph.facebook.com/' + msg.id + '/picture?type=large" alt="Profile Picture" /></a>');
				$('#link').html('<a href="http://localhost:3000/find/' + url + '">Direct link to this result!</a>');
			},
			error: function(x, e) {
				$('#name').text(x.responseText).addClass('error');
			}
		});		
		return false
	});
	
});