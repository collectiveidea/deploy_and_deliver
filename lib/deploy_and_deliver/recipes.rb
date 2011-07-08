Capistrano::Configuration.instance.load do
  
  namespace :pivotal_tracker do
    def initialize_connection
      PivotalTracker::Client.use_ssl = self[:pivotal_tracker_ssl]
      PivotalTracker::Client.token = self[:pivotal_tracker_token]
    end

    def project 
      @project ||= begin
                     initialize_connection
                     PivotalTracker::Project.find(self[:pivotal_tracker_project_id])
                   end
    end

    desc "deliver your project's 'finished' stories"
    task :deliver_stories do
      require 'pivotal-tracker'
      puts "* delivering tracker stories ..."

      stories = project.stories.all(:state => 'finished')
      stories.each(&:deliver!)
      
      puts "* delivered #{stories.size} stories (#{stories.sum(&:estimate)} points)"
      stories.each do |story|
        puts "  - #{story.story_type}: #{story.name} (#{story.estimate} points)"
      end
    end

    desc "Mark the deploy with a release story"
    task :mark_release do
      require 'pivotal-tracker'
      story = project.stories.create(
        :name => "#{ENV['USER']} released to #{stage} at #{Time.now.strftime("%x %X")}",
        :story_type => "release"
      )
      story.update(:current_state => "accepted")
    end
  end
  
end
