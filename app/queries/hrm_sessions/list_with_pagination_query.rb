module HrmSessions
  class ListWithPaginationQuery < ApplicationQuery
    def initialize(scope: HrmSession, page: 0, per_page: 15)
      @scope = scope
      @page = page
      @per_page = per_page
    end

    def build_query
      @scope.includes(:user)
            .select(select_statement)
            .joins(join_data_points_statement)
            .group(group_statement)
            .paginate(page: @page, per_page: @per_page)
            .order(created_at: :desc)
    end

    private

    def select_statement
      <<~SQL.squish
        hrm_sessions.id,
        hrm_sessions.user_id,
        hrm_sessions.duration_in_seconds,
        hrm_sessions.created_at,
        max(hrm_data_points.beats_per_minute) as max_beats_per_minute,
        min(hrm_data_points.beats_per_minute) as min_beats_per_minute,
        avg(hrm_data_points.beats_per_minute) as avg_beats_per_minute
      SQL
    end

    def join_data_points_statement
      <<~SQL.squish
        inner join hrm_data_points on hrm_sessions.id = hrm_data_points.hrm_session_id
      SQL
    end

    def group_statement
      <<~SQL.squish
        hrm_sessions.id,
        hrm_sessions.user_id,
        hrm_sessions.duration_in_seconds,
        hrm_sessions.created_at
      SQL
    end

  end
end