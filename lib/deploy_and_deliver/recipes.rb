Capistrano::Configuration.instance.load do
  
  namespace :pivotal_tracker do
    desc "deliver your project's 'finished' stories"
    task :deliver_stories do
      require 'pivotal-tracker'

      PivotalTracker::Client.use_ssl = self[:pivotal_tracker_ssl]
      PivotalTracker::Client.token = pivotal_tracker_token
      project = PivotalTracker::Project.find(pivotal_tracker_project_id)
      
      puts "* delivering tracker stories ..."

      stories = project.stories.all(:state => 'finished')
      stories.each(&:deliver!)
      
      puts "* delivered #{stories.size} stories (#{stories.sum(&:estimate) points})"
      stories.each do |story|
        puts "  - #{story.story_type}: #{story.name} (#{story.estimate} points)"
      end
    end
  end
  
end