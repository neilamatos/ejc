// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require autocomplete-rails
//= require turbolinks
//= require bootstrap
//= require meiomask
//= require nprogress
//= require nprogress-ajax
//= require_tree .
jQuery(document).on("page:load turbolinks:load", function() {
  NProgress.configure({
    showSpinner: false,
    ease: 'ease',
    speed: 500
  });

  $(".chosen-select").chosen({
    no_results_text: ""
  });

  $(".chosen-select-no-search").chosen({
    disable_search_threshold: 1000
  });

  // Showing tooltips
  $('body').tooltip({
      selector: 'input,select,textarea'
  });
  $('body').tooltip({
      selector: 'i'
  });

  $('.tool-tip').tooltip({title: $(this).attr("title")});

  $(".ajax-update-select").on("change", function(event){
    $.ajax({
      url: $(event.target).data("url"),
      data: {
          object_id: $(event.target).val(),
          target: $(event.target).data("target")
      },
      dataType: "script"
    });
  });

  $(".date-picker").each(function() {
    $(this).setMask({ mask: "99/99/9999" });
    $(this).datetimepicker({
      format: 'DD/MM/YYYY',
      locale: moment.locale('pt-br'),
      icons: {
        next: "fa fa-chevron-right",
        previous: "fa fa-chevron-left"
      }
    })
  });

  set_masks(null);

  jQuery("#show_password").on("click", function(event) {
    if(jQuery("#password").is(":visible")) {
      jQuery("#password").hide();
      jQuery("#password_confirmation").hide();
      jQuery("#show_password").text("Alterar senha");
    }
    else {
      jQuery("#user_password_confirmation").val("");
      jQuery("#user_password").val("");
      jQuery("#password").show();
      jQuery("#password_confirmation").show();
      jQuery("#show_password").text("Descartar alterações na senha");
    }
    event.preventDefault();
    return false;
  });

  $('.panel-collapsable .panel-body').on('show.bs.collapse', function (event) {
    $('.panel-collapsable .panel-heading .fa-chevron-down').toggleClass('fa-chevron-down fa-chevron-up');
  });

  $('.panel-collapsable .panel-body').on('hide.bs.collapse', function (event) {
    $('.panel-collapsable .panel-heading .fa-chevron-up').toggleClass('fa-chevron-up fa-chevron-down');
  });

  $("#filter-form .btn-filter-search").on("click", function(event){
    $("#filter-form").submit();
    event.preventDefault();
  });

  $("#filter-form").find("input[type=search], input[type=text]").on("keypress", function(event){
    if(event.which == 13)  // the enter key code
    {
      $(event.target).closest("form").submit();
      return false;
    }
  });
});

function set_masks() {
  var mask_selector = "input[data-mask]";
  $(mask_selector).each(function() {
    if ($(this).data('mask') !== undefined && $(this).data('mask') !== '') {
      var reverse_flag = "fixed";
      if ($(this).data('reverse') !== undefined && $(this).data('reverse')) {
        reverse_flag = "reverse";
      }
      $(this).setMask({ mask: $(this).data('mask').toString(), type: reverse_flag });
    }
  });
}
