require 'rails_helper'

RSpec.describe "hrm_sessions/new", type: :view do
  before(:each) do
    assign(:hrm_session, HrmSession.new())
  end

  it "renders new hrm_session form" do
    render

    assert_select "form[action=?][method=?]", hrm_sessions_path, "post" do
    end
  end
end
