class HrmSessionsController < ApplicationController
  # GET /hrm_sessions
  def index
    @hrm_sessions = HrmSessions::ListWithPaginationQuery.call(page: params[:page])
  end

  # GET /hrm_sessions/1
  def show
    @hrm_session = HrmSessions::FindQuery.call(hrm_session_id: params[:id]).first
  end
end
