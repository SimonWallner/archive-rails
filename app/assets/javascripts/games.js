/*
 * This function gathers 'mixed fields' and returns them as an array.
 * This function expects the following structure
 * <div class="${fieldName}_row">
 *      <div id="${fieldName}_name_${index}">...</div>
 *      <div id="${fieldName}_info_${index}">...</div>
 * </div>
 */
var gatherFieldIntoArray = function(fieldName) {
    var output = [];

    var fieldCount = $('.' + fieldName + '_row').length;

    for (var i = 0; i < fieldCount; i++) {
        var name = $('#' + fieldName + '_name_' + i).val();

        if (name !== '') {
            var dev = {
                name: name,
                info: $('#' + fieldName + '_info_' + i).val(),
            }
            output.push(dev);
        }
    }
    return output;
}

$(document).ready(function() {
    $(".taggify").each(function(_, element) {
        $(element).tagit({allowSpaces: true});
    });

    $('.addDeveloperButton').each(function(_, element) {
        element.onclick = function() {
            var developerRows = $('.developer_row');
            var lastRow = developerRows[developerRows.length -1];
            $(lastRow).after(lastRow.clone);
        };
    });



    $('form#edit-game').submit(function () {

        var fields = {};

        // mixedFields
        fields.developers = gatherFieldIntoArray('developer');
        fields.publisher = gatherFieldIntoArray('publisher');
        fields.distributor = gatherFieldIntoArray('distributor');
        fields.credits = gatherFieldIntoArray('credits');


        $('<input/>', {
            type: 'hidden',
            name: 'fields',
            value: JSON.stringify(fields)
        }).appendTo(this);


        var anzdates = $('[id^="year_release_date"]').length;
        var datestring = '';
        for(var i = 1; i <= anzdates; i++){
            if($('#year_release_date' + i).val())
                datestring = datestring + $('#day_release_date' + i).val() + ':' +
                                          $('#month_release_date' + i).val() + ':' +
                                          $('#year_release_date' + i).val() + ':' +
                                          $('#text_release_date' + i).val() + ',';
        }
        datestring = datestring.substr(0, datestring.length -1);

        
        var anzuserdef = $('[id^="name_userdefined"]').length;
        var userdefstring = '';
        for(var i = 1; i <= anzuserdef; i++){
            userdefstring = userdefstring + '{"name":"' + $('#name_userdefined' + i).val() + '",' +
                                            '"content":"' + $('#content_userdefined' + i).val() + '"},';
        }
        if($('#new_external_links').length > 0 && $('#new_external_links').val().length > 0){
            userdefstring = userdefstring + '{"name":"External Links","content":"' + $('#new_external_links').val() + '"},';
        }
        if($('#new_aggregate_scores').length > 0 && $('#new_aggregate_scores').val().length > 0){
            userdefstring = userdefstring + '{"name":"Aggregate Scores","content":"' + $('#new_aggregate_scores').val() + '"},';
        }
        if($('#new_review_scores').length > 0 && $('#new_review_scores').val().length > 0){
            userdefstring = userdefstring + '{"name":"Review Scores","content":"' + $('#new_review_scores').val() + '"},';
        }
        userdefstring = '[' + userdefstring.substr(0,userdefstring.length -1) + ']';

        $('input[type="hidden"][id^="new_"]').val('');
        $('#new_release_dates').val(datestring);
        $('#new_fields').val(userdefstring);

		// TODO refactor this whole mess
		// I started here, but for some reason it didn't pan out
		//
		var formFields = [
			{visibleFormName: 'developer', hiddenFormName: 'new_developers'},
			{visibleFormName: 'publisher', hiddenFormName: 'new_publishers'},
			{visibleFormName: 'distributor', hiddenFormName: 'new_distributors'},
			{visibleFormName: 'credits', hiddenFormName: 'new_credits'},
			{visibleFormName: 'series', hiddenFormName: 'new_series'}
			];
		        $.each(formFields, function(_, field) {
			var nameFields = $('.' + field.visibleFormName + '_link');
			var infoFields = $('.' + field.visibleFormName + '_text');
			
			var dataArray = nameFields.toArray().reduce(function(previous, current, index) {
				var datum = $(current).val() + ':';
				
				var infoValue = $(infoFields[index]).val()
				if (infoValue) {
					datum += infoValue;
				}
				
				previous.push(datum);
				return previous;
			}, []);
			
			$('#' + field.hiddenFormName).val(dataArray.join());
		        });

        $.each(['developer','publisher','distributor','credits', 'series'], function(index, val){
            var input_field_name = 'new_' + val;
            if(input_field_name.lastIndexOf('s') !== (input_field_name.length - 1))
                input_field_name = input_field_name + 's';
            $('.' + val + '_link').each(function(){
                if($(this).val()) {
					// XXX
					// hack ahead!
					// the code below expects to find value where there is none
					var value = $(this).prev().val() || $(this).prev().prev().val();
					
					
                    $('#' + input_field_name).val(
                        $('#' + input_field_name).val() +
                        (value
                            ? value.replace('additional-info', $(this).next().val())
                            : $(this).val() + ':' + $(this).next().val() + ',' )
                    );
                }
            });
        });


        //escape linebreacks from json inputs
        $('[id^="new_"]').each(function() {
            $(this).val($(this).val().replace(/\n/g, "\\n"));
        });

        event.preventDefault();

        $(this).ajaxSubmit(
            function(data) {
                var content = $(data).find( '#error_explanation' );
                if(content.length > 0){
                    $('#error_explanation').remove();
                    $('form').append( content );
                }else{
                    window.location = $('form').attr('action');
                }
            }
        );
    });

});
