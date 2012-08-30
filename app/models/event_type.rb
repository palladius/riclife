class EventType < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :name

  searchable_by :name

	def self.dflt_create( eventtype , icon = nil )
    x = EventType.find_or_create_by_name(
      eventtype ,
      :icon => '' , # (icon | "#{eventtype}.png"),
      :active => true
    )
    puts("EventType.dflt_create( #{x.id} <-- '#{eventtype}'): DEBUG --> #{x.id || 'Something gone wrong'}")

  end

  # def on_save
  #   puts "ON_SAVE: che succede???"
  # end
  def initialize(params = nil)  
    super  
    self.icon = "http://www.goliardia.it/immagini/persone/palladius.jpg" unless self.icon  
    self.active ||= true
    #self.price = 1.50 unless self.price
  end

  #TODO  definisci qualcosa tipo un on_save() { se icona NON e' definita fai programmaticamente un default che sia = nome + '.png' }

  def to_s
    name
  end

  alias :to_label :to_s
end
