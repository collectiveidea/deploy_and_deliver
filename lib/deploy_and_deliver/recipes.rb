Capistrano::Configuration.instance.load do
  
  namespace :pivotal_tracker do
    def deliverer
      @deliverer ||= DeployAndDeliver::Project.new(self)
    end

    desc "deliver your project's 'finished' stories"
    task :deliver_stories do
      puts "* delivering tracker stories ..."
      deliverer.deliver_and_report
    end

    desc "Mark the deploy with a release story"
    task :mark_release do
      story = @deliverer.project.stories.create(
        :name => "#{ENV['USER']} released to #{stage} at #{Time.now.strftime("%x %X")}",
        :story_type => "release"
      )
      story.update(:current_state => "accepted")
    end
  end
  
end
