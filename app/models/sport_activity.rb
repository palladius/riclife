class SportActivity < ActiveRecord::Base
  
    #$activities = %w{  jogging bike swim gym sex }.sort
    $activitiesRegEx = /^(jog|bike|swim|gym|sex|spin|roll)$/
    $activities = $activitiesRegEx.source.split(/\)|\(/)[1].split('|').sort.uniq
    DESCRIPTION = '
      - before_save metti il computo delle calorie se non è già esistente..
      - metti casella di scelta per le sporerie, magari che attinge direttamente dalla tabella $calories_per_hour
    '
    
    $calories_per_hour = {
      :sex => 500 ,
      :run => 800 ,
      :spin => 1000 ,
      :gym  => 600 ,
      :swim => 500 ,
      :bike => 400
    }
    
    # belongs_to :person #, :foreign_key => "person_id", :class_name => 'Person'
    # validates_associated :person
    validates_format_of :activity, :with => $activitiesRegEx, :message => "Must be of type: #{$activities.join(', ')}"
     
    searchable_by :name, :description, :activity
    #TBD richiedi che appartenga...
    
    def to_s
      ulterior = name ? ": #{name}" : ''
      name || "#{person_id} did a #{duration}' #{activity}" + ulterior
    end
    
    # per ora lo calcolo cosi
    def auto_calories 
      cals_per_hour = $calories_per_hour.fetch(activity,42)
      cals_per_hour
    end
end
