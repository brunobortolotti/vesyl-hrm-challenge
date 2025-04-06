require 'rails_helper'

RSpec.describe "hrm_sessions/edit", type: :view do
  before(:each) do
    @hrm_session = assign(:hrm_session, HrmSession.create!())
  end

  it "renders the edit hrm_session form" do
    render

    assert_select "form[action=?][method=?]", hrm_session_path(@hrm_session), "post" do
    end
  end
end
