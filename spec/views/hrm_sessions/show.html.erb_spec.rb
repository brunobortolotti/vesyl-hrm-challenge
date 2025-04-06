require 'rails_helper'

RSpec.describe "hrm_sessions/show", type: :view do
  before(:each) do
    @hrm_session = assign(:hrm_session, HrmSession.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
