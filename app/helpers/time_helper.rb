module TimeHelper

  def foo
    'bar_time'
  end
  
end



#   # OK sto barando, metto le date nelle strings, embeh? :(
# class Date
#   # today? esiste ma non tomorrow?
#   def tomorrow?
#     (self - 1.day).today?
#   end
#   def yesterday?
#     (self + 1.day).today?
#   end
#     
# 
#   
# end # Date class


class  ActiveSupport::TimeWithZone
#  include ActionView::Helpers::DateHelper
  #helper DateHelper
  
  # today? esiste ma non tomorrow?
  def tomorrow?
    (self - 1.day).today?
  end
  def yesterday?
    (self + 1.day).today?
  end
  
    # shoould give a good date info..
  def human_date() # for Date object
    # return 'tomorrow' if tomorrow?
    # return 'today' if today?
    # return 'yesterday' if yesterday?
    # return "HumanDateBoh(#{to_s})" # TBD
    cool_date2()
  end
  
  def cool_date2(italian_translate=true)
    date_cool_str = DateHelper.distance_of_time_in_words_to_now(self) 
    date_cool_str = date_cool_str.gsub('about','circa')   if italian_translate
	  event.past? ? "#{date_cool_str} fa" : "tra #{date_cool_str}"
	end
	
end

#class ActionView::Helpers::DateHelper
#  
#  def cool_date(datetime,italian_translate = true) #    def cool_date(italian_translate=true)
#      date_cool_str = DateHelper.distance_of_time_in_words_to_now(datetime) 
#      date_cool_str = date_cool_str.gsub('about','circa')   if italian_translate
#  	  event.past? ? "#{date_cool_str} fa" : "tra #{date_cool_str}"
#  end
#  
#end
