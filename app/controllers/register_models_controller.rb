class RegisterModelsController < ApplicationController
  before_action :set_register_model , only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , :except => [:index]
  before_action :is_admin?, :except => [:index, :show]

  # GET /register_models
  # GET /register_models.json
  def index
    @register_models = RegisterModel.all
  end

  # GET /register_models/1
  # GET /register_models/1.json
  def show
  end

  # GET /register_models/new
  def new
    @register_model = RegisterModel.new
  end

  # GET /register_models/1/edit
  def edit
  end

  # POST /register_models
  # POST /register_models.json
  def create
    @register_model = RegisterModel.new(register_model_params)

    respond_to do |format|
      if @register_model.save
        format.html { redirect_to @register_model, notice: 'Register model was successfully created.' }
        format.json { render :show, status: :created, location: @register_model }
      else
        format.html { render :new }
        format.json { render json: @register_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /register_models/1
  # PATCH/PUT /register_models/1.json
  def update
    respond_to do |format|
      if @register_model.update(register_model_params)
        format.html { redirect_to @register_model, notice: 'Register model was successfully updated.' }
        format.json { render :show, status: :ok, location: @register_model }
      else
        format.html { render :edit }
        format.json { render json: @register_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /register_models/1
  # DELETE /register_models/1.json
  def destroy
    @register_model.destroy
    respond_to do |format|
      format.html { redirect_to register_models_url, notice: 'Register model was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_register_model
      @register_model = RegisterModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def register_model_params
      params.require(:register_model).permit(:name, :explanation, :document)
    end

    # Ensure a Admin is performing the operation.
    def is_admin?
      return true if user_signed_in? and current_user.confirmed? and current_user.admin?
      flash[:alert] = "Only #{ENV['ADMIN_ROLE']}s are allowed to perform this action."
      redirect_to register_models_path
    end
end
