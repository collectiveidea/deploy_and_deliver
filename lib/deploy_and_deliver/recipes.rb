Capistrano::Configuration.instance.load do
  
  namespace :pivotal_tracker do
    desc "deliver your project's 'finished' stories"
    task :deliver_stories do
      require 'rubygems'
      require 'active_resource'

      class Story < ActiveResource::Base ; end

      protocol = self[:pivotal_tracker_ssl] ? 'https' : 'http'
      Story.site = "#{protocol}://www.pivotaltracker.com/services/v2/projects/:project_id"
      Story.headers['X-TrackerToken'] = pivotal_tracker_token
      
      puts "* delivering tracker stories ..."
      response = Story.put(:deliver_all_finished, :project_id => pivotal_tracker_project_id)

      begin
        require 'sax-machine'
        class Story
          include SAXMachine
          element :name
          element :story_type
          element :estimate
          element :description
        end
        class Stories
          include SAXMachine
          elements :story, :as => :stories, :class => Story
        end
        doc = Stories.parse(response.body)
        puts "* delivered #{doc.stories.length} stories"
        doc.stories.each do |story|
          puts "  - #{story.story_type}: #{story.name} (#{story.estimate} points)"
        end
      rescue LoadError => e
        puts "* stories delivered."
      end
    end
  end
  
end