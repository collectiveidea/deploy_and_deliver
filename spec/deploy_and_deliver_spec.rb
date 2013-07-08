require 'deploy_and_deliver'
require 'vcr'

Configuration = {
  :pivotal_tracker_token      => ENV['PIVOTAL_TRACKER_TOKEN'] || '<TOKEN>',
  :pivotal_tracker_project_id => ENV['PIVOTAL_TRACKER_PROJECT_ID'] || '477915'
}

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<TOKEN>') { Configuration[:pivotal_tracker_token] }
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  # so we can use `:vcr` rather than `:vcr => true`;
  # in RSpec 3 this will no longer be necessary.
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

describe "DeployAndDeliver::Project" do
  describe "constructor" do
    it "requires a Pivotal Tracker token"
    it "can use SSL"
    
    it "loads a project", :vcr => {:cassette_name => 'project'} do
      deliverer = DeployAndDeliver::Project.new(Configuration)
      deliverer.project.should_not be_nil        
    end
  end
  
  describe "deliver_and_report" do
    it "delivers finished stories", :vcr => {:cassette_name => 'deliver_and_report'} do
      deliverer = DeployAndDeliver::Project.new(Configuration)
      deliverer.deliver_and_report.size.should == 1
    end
  end
end

