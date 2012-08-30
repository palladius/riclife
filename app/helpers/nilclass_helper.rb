
  # $Id$
  # tolta perchè creava casino, per riabilitarla rinominala a NilClass :)
# TBD cancellami..

class NilClassCancellami
  # def nomethod
  #   nil #'NilClass.nomethod(): nil :)'  #'apps per nilclass ma guarda te cosa mi tocca fre...'
  # end
  # def loaded?(s)
  #   false
  # end
  
#  def nomethod() nil; end 
  def nomethod_ng() nil; end 
  
  def include?() nil; end
  
  %w{ :birthday      :feed  
     :feed2       :apps  
     :charisma       :constitution  
     :dexterity 
     :wisdom       :created_at  
     :updated_at       :intelligence  
     :location       :birthday  
     :feed        :feed2  
      :apps  
      :charisma  
      :constitution  
      :dexterity  
      :wisdom  
      :created_at  
      :updated_at  
      :intelligence  
      :location  
      :male  
      :mobile  
      :virtual  
      :name  
      :surname  
      :nickname  
      :notes  
      :organisation 
      :quote 
      :relevance  
      :starred  
      :strength  
      :location  
      :male  
      :lat  
      :lng  
      :to_ical  
     :tags  
     :vote  
      :sexappeal 
   }.each{ |method_name| 
     alias method_name :nomethod_ng
     }
  
  def to_label
      "-" # ho sempre desiderato poter dire NIL in HTML!!! direi un grigino e una epsilon greca
  #      "<font class='unactive'>{empty}</font>" # ho sempre desiderato poter dire NIL in HTML!!! direi un grigino e una epsilon greca
  end
  
  def method_missing_obsolete(method_name, *args, &block)
    # logger.info "NilClass.method_missing('#{method_name}')"
    "NilClass.method_missing('#{method_name}')"
  end

end
