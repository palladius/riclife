# ActsAsCarlesso

# TBD cose da fare
# - logga creazione e editing con UTENTE che lha triggerato
# - metti magari il capo last_updated_by ?!?

module ActsAsCarlesso
  
  def self.included(base)
    base.extend(BaseMethods)
  end

  module BaseMethods
    def acts_as_carlesso
      self.send :include,InstanceMethods
      self.send :extend, ClassMethods
    end
  end
  
  module ClassMethods
    def give_me_the_time
      Time.new 
    end
    # def about
    #   "Bella Ric, come va? Figata sto modulo ActsAsCarlesso :) - For more info contact the author -- palladiusbonton@gmail.com"
    # end
    def about
      "(C) Qualche info su sto modello stesso TBD: #{self}"
    end
    
    def logga2(str)
       logger.info "#{yellow 'AAC_LOG1' rescue 'AAC_LOG_GIALLO_ECXETZ'}: #{str}"
       puts "#{yellow 'AAC_LOG2'}: #{str}"
     end
     
  end

  module InstanceMethods 
     def is_this_record_very_old?
       raise "Column created_at not found" unless self.class.columns_hash.keys.include?("created_at")
       raise "Column created_at not initialized" if created_at.nil?
       created_at < Time.new - 5.days
     end
     
     def ricname
       return name if  self.class.columns_hash.keys.include?("name")
       return self.to_s if  self.class.columns_hash.keys.include?(to_s)
       return "bohhhh!!! TBD mostrami attributi alternativi.."
     end
     
     # returns notes, or descrption, or wha'ever
     def ric_description
       return notes       if  self.class.columns_hash.keys.include?("notes")
       return description if  self.class.columns_hash.keys.include?("description")
       return "Descrizione ignota!!!"
     end
     
     def about
       "Benvenuto su ActAsCarlesso!
       Ecco qui qualche info sull'istanza '#{self}' del modello TBD: #{self.class}"
     end
     
     #def yellow
     
 
  end
  
  # def ActiveRecord::Base
  #   # This function can be safely put into a before_save or before_validate stuff
  #   # non va mi sa..
  #   # def ric_change_parameter(param,value)
  #   #   if attribute_present?(param) && respond_to?(param) # e verifica che la classe abbia tale campo..
  #   #     logger.info "Not changing value for #{self.class}::#{param}"
  #   #   else
  #   #     self.send(param,value) rescue "ActsAsCarlesso::ric_change_parameter() failed: #{$!}"
  #   #   end 
  #   # end
  #   
  # end
end
