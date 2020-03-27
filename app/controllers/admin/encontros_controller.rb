class Admin::EncontrosController < ApplicationController
  load_and_authorize_resource :class => 'Encontro'
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error
  before_action :set_encontro, only: [:show, :edit, :update, :destroy]

  # GET /admin/encontros
  # GET /admin/encontros.json
  def index
    @q = Encontro.order("descricao ASC").search(params[:q])
    @encontros = @q.result.page(params[:page])
    @total_registros = @q.result.count
  end

  # GET /admin/encontros/1
  # GET /admin/encontros/1.json
  def show

  end

  # GET /admin/encontros/new
  def new
    @encontro = Encontro.new
  end

  # GET /admin/encontros/1/edit
  def edit

  end

  # POST /admin/encontros
  # POST /admin/encontros.json
  def create
    @encontro = Encontro.new(encontro_params)
    respond_to do |format|
      if @encontro.save
        format.html { redirect_to admin_encontros_path, notice: 'Encontro foi criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @encontro }
      else
        format.html { render action: 'new' }
        format.json { render json: @encontro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/encontros/1
  # PATCH/PUT /admin/encontros/1.json
  def update
    respond_to do |format|
      if @encontro.update(encontro_params)
        format.html { redirect_to admin_encontros_path, notice: 'Encontro foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @encontro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/encontros/1
  # DELETE /admin/encontros/1.json
  def destroy
    @encontro.destroy
    respond_to do |format|
      format.html { redirect_to admin_encontros_url, notice: 'Encontro foi deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encontro
      @encontro = Encontro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encontro_params
      params.require(:encontro).permit(:descricao, :data)
    end
end
