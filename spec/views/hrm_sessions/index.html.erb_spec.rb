require 'rails_helper'

RSpec.describe "hrm_sessions/index", type: :view do
  before(:each) do
    assign(:hrm_sessions, [
      HrmSession.create!(),
      HrmSession.create!()
    ])
  end

  it "renders a list of hrm_sessions" do
    render
  end
end
