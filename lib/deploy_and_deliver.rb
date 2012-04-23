require 'pivotal-tracker'

module DeployAndDeliver
  class Project
    attr_reader :project

    def initialize(context)
      PivotalTracker::Client.use_ssl = context[:pivotal_tracker_ssl]
      PivotalTracker::Client.token = context[:pivotal_tracker_token]
      @project = PivotalTracker::Project.find(context[:pivotal_tracker_project_id])
    end

    def deliver_and_report
      stories = project.stories.all(:current_state => 'finished')
      stories.each{|story| story.update :current_state => 'delivered'}

      puts "* delivered #{stories.size} stories (#{stories.map(&:estimate).inject(:+)} points)"
      stories.each do |story|
        puts "  - #{story.story_type.capitalize}: #{story.name} (#{story.estimate} #{story.estimate == 1 ? "point" : "points"})"
      end
    end
  end

end
