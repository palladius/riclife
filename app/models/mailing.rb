
# copiato da episodio 127:
class Mailing < ActiveRecord::Base
  
  # solo per root direi :)
   searchable_by :subject

  def deliver
    puts "Mailing.deliver: sto cercando di mandare una email"
    sleep 3 # virtualmente sono un job costoso :)
    # manda email qui TBD
    update_attribute(:delivered_at, Time.now)
  end

  def get_emails
    [ "palladiusbonton@gmail.com", "palladius@email.it" ] # TBD prendi da root / god
  end


  def title
    subject
  end

  alias :to_s :title
  
end
