class FacebookSocialMissionValidator < MissionValidator
  def check(params)
    begin
      if params[:oracle_token]
        update_enrollment_oracle params[:oracle_token]
      else
        update_enrollment_likes
      end
    rescue Exception => e
      logger.warn 'Facebook check fucked everything!'
      false
    end
  end

  def accomplished?
    likes_enough? && oracle_validated?
  end

  def initialize_params
    {
      likes:        0,
      oracle:       false,
      oracle_token: oracle_token
    }
  end

  protected
  def oracle_token
    rand(10**99).to_s(36)
  end

  def update_enrollment_likes
    if link_stats.nil?
      #logger.warn 'Fql did not work: #{check_query}'
      return
    end
    enrollment_params[:fb]    = link_stats.symbolize_keys
    enrollment_params[:likes] = enrollment_params[:fb][:like_count]
    enrollment.save!
  end

  def update_enrollment_oracle(token)
    if mission_params[:oracle] && token == enrollment_params[:oracle_token]
      enrollment_params[:oracle] = true
      enrollment.save!
    end
  end

  def link_stats
    Fql.execute(check_query).first
  end

  def check_query
    "SELECT url, normalized_url, share_count, like_count, comment_count, total_count, commentsbox_count, comments_fbid, click_count FROM link_stat WHERE url=\"#{enrollment.url}\""
  end

  def likes_enough?
    enrollment_params[:likes] > mission_params[:likes]
  end

  def oracle_validated?
    !mission_params[:oracle] || enrollment_params[:oracle]
  end
end
