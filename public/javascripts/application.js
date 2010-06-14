// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready( function() {
	
	// Remove info text above search form
	$('#guide').hide();
	
	// Add value to input, and remove on focus
	$('input#id').each( function() {
		value = 'Enter your Facebook picture URL here!';		
		if( $(this).val().length < 1 ) {
			$(this).val(value).attr('title', value).toggleClass('blur').focus( function() {
				if( $(this).val() == $(this).attr('title') ) {
					$(this).val('').toggleClass('blur');
				}
			}).blur( function() {
				if( $(this).val() == '' || $(this).val() == ' ' ) {
					$(this).val($(this).attr('title')).toggleClass('blur');
				}
			});
		}
	});
	
	// AJAX stuff
	// Happens when #faceform is submitted
	$('#faceform').submit( function() {
		url = encodeURIComponent($('#id').val());
		furl = 'http://facebook.com/profile.php?id=';
		$.ajax({
			url: '/find.json?id=' + url,
			dataType: 'json',
			beforeSend: function() {
				$('#name').html('<img src="/images/loading.gif" alt="" />');
				$('#picture').empty();
				$('#link').empty();
			},
			success: function(msg) {
				$('#name').html('<a href="' + furl + msg.id + '">' + msg.name + '</a>');
				$('#picture').html('<a href="' + furl + msg.id + '"><img src="http://graph.facebook.com/' + msg.id + '/picture?type=large" alt="Profile Picture" /></a>');
				$('#link').html('<a href="http://bob.eplekake.net/find/' + url + '">Direct link to this result!</a>');
			},
			error: function(x, e) {
				$('#name').text(x.responseText).addClass('error');
			}
		});		
		return false
	});
	
});