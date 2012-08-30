module ArraysHelper

  def foo2
    'array.bar'
  end
end



  ###################################
  # redefine string stuff... va messo fuori dal modulo se no col cacchio che ridefinisce string...
class Array

  def valid?
  #  self.map{|x| [x.id, x.to_s] unless x.valid? } - [ nil ]
    self.map{|x| x.id unless x.valid? } - [ nil ]
  end
  
  def venue_types
    map{|el| el.venue_type}
  end
  
    def uniq_c(min_cardinality = 1) # sort=false)
       hash=Hash.new
       self.map{|x| hash[x] = (hash[x] + 1) rescue 1  }
       return hash.select{|k,v| v >= min_cardinality}
    end
  
end # Array
