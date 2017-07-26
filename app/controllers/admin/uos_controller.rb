class Admin::UosController < ApplicationController
  load_and_authorize_resource :class => 'Uo'
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error
  before_action :set_uo, only: [:show, :edit, :update, :destroy]

  # GET /admin/uos
  # GET /admin/uos.json
  def index
    @q = Uo.order("nome ASC").search(params[:q])
    @uos = @q.result.page(params[:page])
    @total_registros = @q.result.count
  end

  # GET /admin/uos/1
  # GET /admin/uos/1.json
  def show

  end

  # GET /admin/uos/new
  def new
    @uo = Uo.new
    @estados = Estado.order("nome ASC").all.collect {|o| [o.nome, o.id]}
    @cidades = []
  end

  # GET /admin/uos/1/edit
  def edit
    @estados = Estado.order("nome ASC").all.collect {|o| [o.nome, o.id]}
    @cidades = @uo.estado.blank? ? ["É preciso selecionar um estado primeiro", ""] : @uo.estado.cidades.collect {|c| [c.nome, c.id]}
  end

  # POST /admin/uos
  # POST /admin/uos.json
  def create
    @uo = Uo.new(uo_params)


    respond_to do |format|
      if @uo.save
        format.html { redirect_to admin_uos_path, notice: 'Uo foi criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @admin_uo }
      else
        @estados = Estado.order("nome ASC").all.collect {|o| [o.nome, o.id]}
        @cidades = @uo.estado.blank? ? ["É preciso selecionar um estado primeiro", ""] : @uo.estado.cidades.collect {|c| [c.nome, c.id]}
        format.html { render action: 'new' }
        format.json { render json: @admin_uo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/uos/1
  # PATCH/PUT /admin/uos/1.json
  def update
    respond_to do |format|
      if @uo.update(uo_params)
        format.html { redirect_to admin_uos_path, notice: 'Uo foi atualizada com sucesso.' }
        format.json { head :no_content }
      else
        @estados = Estado.order("nome ASC").all.collect {|o| [o.nome, o.id]}
        @cidades = @uo.estado.blank? ? ["É preciso selecionar um estado primeiro", ""] : @uo.estado.cidades.collect {|c| [c.nome, c.id]}
        format.html { render action: 'edit' }
        format.json { render json: @uo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/uos/1
  # DELETE /admin/uos/1.json
  def destroy
    @uo.destroy
    respond_to do |format|
      format.html { redirect_to admin_uos_url, notice: 'Uo foi deletada com sucesso.' }
      format.json { head :no_content }
    end
  end

  # Atualiza lista de cidades baseado no estado selecionado
  def update_cidades
    @target_id = params[:target]

    estado = nil
    begin
      estado = Estado.find(params[:object_id])
    rescue
    end

    @objects = {"É preciso selecionar um estado primeiro" => ""}
    if !estado.blank?
      @objects = estado.cidades.order("nome ASC").map{|c| [c.nome, c.id]}.insert(0, "Selecione uma cidade")
    end

    render "layouts/update_ajax_select"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uo
      @uo = Uo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uo_params
      params.require(:uo).permit(:nome, :sigla, :codigo_ug, :cnpj, :endereco, :complemento, :bairro, :estado_id, :cidade_id, :cep)
    end
end
