class HrmSessionsController < ApplicationController
  before_action :set_hrm_session, only: %i[ show edit update destroy ]

  # GET /hrm_sessions
  def index
    @hrm_sessions = HrmSession.includes(:user)
                              .paginate(page: params[:page], per_page: 15)
                              .order(created_at: :desc)
  end

  # GET /hrm_sessions/1
  def show
  end

  # GET /hrm_sessions/new
  def new
    @hrm_session = HrmSession.new
  end

  # GET /hrm_sessions/1/edit
  def edit
  end

  # POST /hrm_sessions
  def create
    @hrm_session = HrmSession.new(hrm_session_params)

    if @hrm_session.save
      redirect_to @hrm_session, notice: "Hrm session was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hrm_sessions/1
  def update
    if @hrm_session.update(hrm_session_params)
      redirect_to @hrm_session, notice: "Hrm session was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /hrm_sessions/1
  def destroy
    @hrm_session.destroy
    redirect_to hrm_sessions_url, notice: "Hrm session was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hrm_session
      @hrm_session = HrmSession.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hrm_session_params
      params.fetch(:hrm_session, {})
    end
end
