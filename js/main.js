	$('.thumbnail').click(function(){
		var identified = $(this).attr('id');
    var imgSelector = $("#p"+identified+"");
		imgSelector.addClass('shown');
	});
$('.hidden').click(function(){
	$(this).removeClass('shown');
})










