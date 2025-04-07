module HrmSessions
  class FindQuery < ApplicationQuery
    def initialize(scope: HrmSession, hrm_session_id:)
      @scope = scope
      @hrm_session_id = hrm_session_id
    end

    def build_query
      @scope.includes(:user)
            .select(select_statement)
            .joins(join_data_points_statement)
            .joins(join_users_statement)
            .group(group_statement)
            .where(id: @hrm_session_id)
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
        avg(hrm_data_points.beats_per_minute) as avg_beats_per_minute,
        coalesce((
            select sum(duration_in_seconds) from hrm_data_points
            where beats_per_minute >= users.hr_zone1_bpm_min and beats_per_minute <= users.hr_zone1_bpm_max
                and hrm_data_points.hrm_session_id = hrm_sessions.id
        ),0) as zone1_duration,
        coalesce((
            select sum(duration_in_seconds) from hrm_data_points
            where beats_per_minute >= users.hr_zone2_bpm_min and beats_per_minute <= users.hr_zone2_bpm_max
                and hrm_data_points.hrm_session_id = hrm_sessions.id
        ),0) as zone2_duration,
        coalesce((
            select sum(duration_in_seconds) from hrm_data_points
            where beats_per_minute >= users.hr_zone3_bpm_min and beats_per_minute <= users.hr_zone3_bpm_max
                and hrm_data_points.hrm_session_id = hrm_sessions.id
        ),0) as zone3_duration,
        coalesce((
            select sum(duration_in_seconds) from hrm_data_points
            where beats_per_minute >= users.hr_zone4_bpm_min and beats_per_minute <= users.hr_zone4_bpm_max
                and hrm_data_points.hrm_session_id = hrm_sessions.id
        ),0) as zone4_duration
      SQL
    end

    def join_data_points_statement
      <<~SQL.squish
        inner join hrm_data_points on hrm_sessions.id = hrm_data_points.hrm_session_id
      SQL
    end

    def join_users_statement
      <<~SQL.squish
        inner join users on hrm_sessions.user_id = users.id
      SQL
    end

    def group_statement
      <<~SQL.squish
        hrm_sessions.id,
        hrm_sessions.user_id,
        hrm_sessions.duration_in_seconds,
        hrm_sessions.created_at,
        users.hr_zone1_bpm_min,
        users.hr_zone1_bpm_max,
        users.hr_zone2_bpm_min,
        users.hr_zone2_bpm_max,
        users.hr_zone3_bpm_min,
        users.hr_zone3_bpm_max,
        users.hr_zone4_bpm_min,
        users.hr_zone4_bpm_max
      SQL
    end
  end
end