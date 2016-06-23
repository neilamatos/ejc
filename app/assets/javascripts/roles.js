jQuery(document).ready(function() {
  //ordenando o select de permissões ao carregar a página
  order_select("permissions_left");

  jQuery("#add_multiple").on("click", function(event) {
    copy_selected_options(jQuery("#add_multiple").data("left_select"), jQuery("#add_multiple").data("right_select"), "add");
    event.preventDefault();
  });

  jQuery("#remove_multiple").on("click", function(event) {
    copy_selected_options(jQuery("#add_multiple").data("right_select"), jQuery("#add_multiple").data("left_select"), "remove");
    event.preventDefault();
  });
});

/**
 * Copia os valores de um select para outro.
 * @param from_select_id Select de origem, de onde as opções serão copiadas
 * @param to_select_id Select de destino, onde as opções serão colocadas
 */
function copy_selected_options(from_select_id, to_select_id, operation_type) {
  // copiando as opções de um select para outro
  var selected_options = jQuery("#" + from_select_id + " > option:selected").clone();
  jQuery("#" + from_select_id + " > option:selected").remove();
  jQuery("#" + to_select_id).append(selected_options);

  // Criando inputs do tipo hidden quando estiver adicionando os valores
  jQuery.each(selected_options, function(index, object) {
    if (operation_type == "add") {
      jQuery("#" + to_select_id).parent().append("<input id='permission_" + $(object).val() + "' type='hidden' name='permissions[]' value='" + $(object).val() + "' />");
    } else if (operation_type == "remove") {
      jQuery("#permission_" + $(object).val()).remove();
    }
  });

  // ordenando o select depois da cópia das opções
  order_select(to_select_id);
}

function order_select(select_id) {
  // ordenando o select depois da cópia das opções
  var options = jQuery("#" + select_id + " > option").get();
  options.sort(function(o1, o2) { return jQuery(o1).text().toLowerCase() > jQuery(o2).text().toLowerCase() ? 1 : jQuery(o1).text().toLowerCase() < jQuery(o2).text().toLowerCase() ? -1 : 0; });
  jQuery.each(options, function(index, object) {
    jQuery("#" + select_id).append(object);
  });
}