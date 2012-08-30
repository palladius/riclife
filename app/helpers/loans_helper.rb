module LoansHelper

  def quantity_column(r)
    #image_tag("carlesso/persone/#{r.person.photo}.jpg", :height => 20) +
    r.coloured_quantity
  end
  
  def solved_column(r)
    if r.solved
      image_tag( "icons/dialog-apply.png",  :height => 20)
    end
  end
  
  def starred_column(r)
    if r.starred
      image_tag( "icons/stars/yellow.png",  :height => 20)
    end
  end
  
    # soccia che baco che c'era!
  def people_involved_column(r)
    '<span class="loan">' +
     "<font color='darkgreen'>#{link_to(r.ower, r.ower, :border => 0 )}</font>&nbsp;--&gt;&nbsp;" +
     "<font color='darkred'>#{link_to r.creditor,r.creditor}</font>" +
    '</span>'   
  end
  
  def title_column(r)
    link_to(r.to_s.bold, r)
  end

#  def currency_column(r)
#    r.currency_to_html
#  end

  
end
