require "rails_helper"

RSpec.describe HrmSessionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/hrm_sessions").to route_to("hrm_sessions#index")
    end

    it "routes to #new" do
      expect(get: "/hrm_sessions/new").to route_to("hrm_sessions#new")
    end

    it "routes to #show" do
      expect(get: "/hrm_sessions/1").to route_to("hrm_sessions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/hrm_sessions/1/edit").to route_to("hrm_sessions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/hrm_sessions").to route_to("hrm_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/hrm_sessions/1").to route_to("hrm_sessions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/hrm_sessions/1").to route_to("hrm_sessions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/hrm_sessions/1").to route_to("hrm_sessions#destroy", id: "1")
    end
  end
end
