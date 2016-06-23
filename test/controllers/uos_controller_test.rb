require 'test_helper'

class UosControllerTest < ActionController::TestCase
  setup do
    @uo = uos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uo" do
    assert_difference('Uo.count') do
      post :create, uo: { bairro: @uo.bairro, cep: @uo.cep, cidade_id: @uo.cidade_id, cnpj: @uo.cnpj, complemento: @uo.complemento, endereco: @uo.endereco, nome: @uo.nome, sigla: @uo.sigla }
    end

    assert_redirected_to uo_path(assigns(:uo))
  end

  test "should show uo" do
    get :show, id: @uo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uo
    assert_response :success
  end

  test "should update uo" do
    patch :update, id: @uo, uo: { bairro: @uo.bairro, cep: @uo.cep, cidade_id: @uo.cidade_id, cnpj: @uo.cnpj, complemento: @uo.complemento, endereco: @uo.endereco, nome: @uo.nome, sigla: @uo.sigla }
    assert_redirected_to uo_path(assigns(:uo))
  end

  test "should destroy uo" do
    assert_difference('Uo.count', -1) do
      delete :destroy, id: @uo
    end

    assert_redirected_to uos_path
  end
end
