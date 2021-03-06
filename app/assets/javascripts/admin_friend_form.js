$(document).on('turbolinks:load', function () {
  activateChosen();

  $('#friend_ethnicity').change(function() {
    if ($(this).find('option:selected').text() == "Other") {
      $('.other_ethnicity_wrapper').show();
    } else {
      if ($('.other_ethnicity_wrapper').is(":visible")) {
        $('#friend_other_ethnicity').val('');
        $('.other_ethnicity_wrapper').hide();
      }
    }
  });

  $('#friend_no_a_number').change(function() {
    if ($(this).prop('checked')) {
      $('#friend_a_number').val('');
    }
  });

  $('#add_family_member_modal').on('shown.bs.modal', function(){
    $('#new_family_member_constructor')[0].reset();
  });

  $('.open_activity_modal').click(function() {
    $('#activity_modal').modal('show');
  });
});

function activateChosen() {
  var all_chosen_selects = $('.chzn-select');
  for (var i=0; i<all_chosen_selects.length;i++) {
    var chosen_select = all_chosen_selects[i];
    $(chosen_select).chosen({
      allow_single_deselect: true,
      no_results_text: 'No results matched',
      width: '100%'
    });

    // remove duplicated chosen-containers
    if ($(chosen_select).next().next().hasClass('chosen-container')) {
      $(chosen_select).next().next().remove();
    }
  }
}


