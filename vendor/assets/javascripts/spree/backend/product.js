$(document).ready(function() {
  $('#selectAll').click(function() {
    if (this.checked) {
      $(':checkbox').each(function() {
        this.checked = true;
      });
    } else {
      $(':checkbox').each(function() {
        this.checked = false;
      });
    }
  });

  $('#deleteAll').click(function() {
    // event.preventDefault();
    var array = [];
    $('#listing_products :checked').each(function() {
      array.push($(this).val());
    });
    console.log(array);

    $("#delete_product_ids").val(array);

  });


  $("#updateTaxon").click(function(event) {
    // event.preventDefault();
    var checked_pr_array = [];
    $('#listing_products :checked').each(function() {
      checked_pr_array.push($(this).val());
    });
    var url = $(this).attr('href');
    $.ajax({
      url: url,
      data: {
        product_ids: checked_pr_array
      },
      type: "GET",
      success: function(response) {
        //console.log(response)
      },
      error: function(xhr, textStatus, errorThrown) {
        //console.log(errorThrown)
      }
    });
  });



});