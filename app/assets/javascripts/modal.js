// ==== Funções para lidar com janelas modais ====
function openModal(modal_id) {
  $("#" + modal_id).modal("show");    
  setupComponents();
}

/**
 * Função chamada para fechar uma modal.
 */
function closeModal(modal_id) {
  $("#"+modal_id).modal('hide');
}
