require 'spec_helper'

describe Mission do

  context 'simple mission' do
    clean_with_transaction_on :all

    before do
      @user = create :user
      @game_version = @user.game_version
      @chapter = create :chapter, game_version: @game_version
      @mission = create :mission, chapter: @chapter
    end

    it 'should compile description' do
      @mission.should have_description_tag 'em', 'Content'
    end
  end
end
