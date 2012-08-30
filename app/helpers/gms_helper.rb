module GmsHelper
  # def subject_column_old(r)
  #   tmp = r.unread ?
  #     r.subject.capitalize.bold :
  #     r.subject.capitalize.italic
  #   link_to(tmp,r).span( :class => 'gms' )
  # end
  # 
  def subject_column(r)
    tmp = r.subject.capitalize.send(  r.unread ? :bold : :italic)
    image_tag('models/gms.png', :height => 12 ) + link_to(tmp,r).span( :class => 'gms' )
  end
end
