module CommentsHelper

  def commentable_id_column(r)
    r.commentable_name rescue "ErrCommentable: #{h $!}"
    #{}"[#{r.commentable_type} ##{r.commentable_id}]"
  end 
  
  def resource_link_column(r)
    #link_to(r.commentable_id, r.commentable_type ) rescue "except: #{$!}"
    r.poly_link() rescue "resource_link_column xcpt: #{$!}"
  end
  
  
  def commentable_type_form_column(record, input_name)
    #biarr = [["Dollar", "$"], ["Kroner", "DKK"]]
    biarr = (Comment::COMMENT_VALID_TYPES  rescue ["Err #{$!}" ]  ).map{|model| [model,model] }  # [["Dollar", "$"], ["Kroner", "DKK"]]
    #collection_select(:record, :commentable_type, State.find(:all, :order => "name"), :id, :name, {}, {:name => input_name} )
    #collection_select(:record, :commentable_type, [{ :id => 1, :name => "2 3" }], :id, :name, {}, {:name => input_name} )
    return select( :record, :commentable_type, biarr  ) rescue "432: #{$!}"
    #423
  end
  
  def commentable_column(r)
    commentable_type_column(r) + link_to(r.commentable.to_s.italic,r.commentable)
  end
  
  def user_id_column(r)
    u = User.find(r.user_id) rescue nil
    link_to(u.to_label,u) if u # rescue "Err #{$!}"
  end
  
  def commentable_type_column(r)
    myicon(r)
  end 
  def body_column(r)
    "<small class='comment comment_body'><i>#{ r.body }</i></small>"
  end
  def title_column(r)
    "<b class='comment'>#{ link_to(r.title,r) }</b>"
  end
  def myicon(r)
    icon("models/#{r.commentable_type.singularize.downcase}") rescue "ERR: #{$!}"
  end
  
  def snippet_column(r)
    "<div  class='comment' >" + 
      #myicon(r)  +
      icon('models/comment.png')  +
      title_column(r) + ' ' +
      body_column(r) +
      "</div>\n"
  end
   
   #   #{}"<span class='comment'>RicModel: #{title}</span>"
  def comment_column(r)
    link_to "Add comment", '/comments/comment_form'
  end

end
