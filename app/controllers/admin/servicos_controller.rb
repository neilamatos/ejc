class Admin::ServicosController < ApplicationController
  load_and_authorize_resource :class => 'Servico'
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error
  before_action :set_pessoa
  before_action :set_servico, only: [:show, :edit, :update, :destroy]

  # GET /admin/servicos
  # GET /admin/servicos.json
  def index
    @q = Servico.where("pessoa_id = ?", @pessoa.id).search(params[:q])
    @servicos = @q.result.page(params[:page])
    @total_registros = @q.result.count
    get_dependencies
  end

  # GET /admin/servicos/1
  # GET /admin/servicos/1.json
  def show

  end

  # GET /admin/servicos/new
  def new
    @pessoa = Pessoa.find(params[:pessoa_id])
    @servico = Servico.new(pessoa_id: @pessoa.id)
    get_dependencies
  end

  # GET /admin/servicos/1/edit
  def edit
    get_dependencies
  end

  # POST /admin/servicos
  # POST /admin/servicos.json
  def create
    @servico = Servico.new(servico_params)
    @servico.pessoa_id = @pessoa.id
    respond_to do |format|
      if @servico.save
        format.html { redirect_to admin_pessoas_path, notice: 'Serviço foi criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @servico }
      else
        get_dependencies
        format.html { render action: 'new' }
        format.json { render json: @servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/servicos/1
  # PATCH/PUT /admin/servicos/1.json
  def update
    respond_to do |format|
      if @servico.update(servico_params)
        format.html { redirect_to admin_pessoa_servicos_path(@pessoa), notice: 'Serviço foi atualizada com sucesso.' }
        format.json { head :no_content }
      else
        get_dependencies
        format.html { render action: 'edit' }
        format.json { render json: @servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/servicos/1
  # DELETE /admin/servicos/1.json
  def destroy
    @servico.destroy
    respond_to do |format|
      format.html { redirect_to admin_pessoa_servicos_url(@pessoa), notice: 'Serviço foi deletada com sucesso.' }
      format.json { head :no_content }
    end
  end

  def autocomplete_nome
    term = params[:term]
    search_term = "%#{term.gsub(' ','%')}%"
    pessoas = Pessoa.limit(10).
                 where('(UPPER(pessoas.nome) ILIKE ? )', search_term.upcase, search_term).
                 order("pessoas.nome ASC").all

    render json: pessoas.map { |pessoa| { id: pessoa.id, label: pessoa.nome, value: pessoa.nome} }
  end

  private
    def set_pessoa
      @pessoa = Pessoa.find(params[:pessoa_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_servico
      @servicos = Servico.find(params[:id])
    end

    def get_dependencies
      @pessoas = Pessoa.order("nome ASC").all.collect {|p| [p.nome, p.id]}
      @encontros = Encontro.order("descricao ASC").all.collect {|e| [e.descricao, e.id]}
      @equipes_funcoes = EquipeFuncao.all.collect {|t| [t.juncao, t.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def servico_params
      params.require(:servico).permit(:pessoa_id, :encontro_id, :equipe_funcao_id)
    end
end
