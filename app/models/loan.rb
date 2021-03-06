# encoding: utf-8
class Loan < ActiveRecord::Base
  searchable_by :title , :description , :quantity, :currency #, :user_from_id, :user_to_id
  acts_as_commentable
    
  #belongs_to :person
  # belongs_to :author, :class_name => "Person", :foreign_key => "author_id"
  belongs_to :creditor, :foreign_key => 'creditor_id', :class_name => 'Person'
  belongs_to :ower,     :foreign_key => 'ower_id',     :class_name => 'Person'

  validates_presence_of :ower, :creditor, :title 
  # quantity puo esser vuota se mi deve ad es un libro
  #default_value_for :currency, "euro"

  def to_s
    title + (solved ? ' [solved]' : '')  + (overdue? ? ' (overdue!!)' : '')
  end

  def coloured_quantity
    color =
    quantity <0
  end

  def color_and_class
    q = quantity || 0
    return ["green", 'positive' ] if q > 0          # loan_credit
    return [ "red",  'negative' ] if q < 0          # loan_debt
    return ['gray',  'neutral' ]                    # loan_solved
  end

  def currency_to_html
    case currency || ''
      when 'euro'
        '€'
      when 'dollar'
        '$'
      when 'pound'
        '£'
      else
        #'??' # currency
        "<small class='loan_currency' >#{currency}</small>"
    end
  end

  def overdue?
    self.date_end < Date.today rescue false
  end

  def coloured_quantity
    cc  =  color_and_class
    col = cc[0]
    cla = cc[1]
    #[ col , cla ] = color_and_class
    "<font color='#{col}' class='loan #{cla}' >#{quantity} #{currency_to_html}</font>"
  end

end
