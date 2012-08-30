class Host < ActiveRecord::Base

  validates_uniqueness_of :name
  searchable_by :name
    acts_as_commentable

  validates_format_of :os, :with => /^(windows|mac|linux|other)$/,
    :message  => " available OSs: windows|mac|linux|other"

  # better one:
  # '\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b'
  
  validates_format_of :ip,
    :with => /(\d{1,3}\.){3}\d{1,3}/,
    #:with => /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ ,
    :message  => " valid IPv4 IP (123.DDD.DDD.DDD)"

  def to_s
    name
  end
  
end
