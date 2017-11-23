
# rake send_mailing
#require '~/lib/ric.rb'

def yellow(s)
  "\033[0;34m#{s}\033[0m"
end

desc "Send mailing attraverso 'rake send_mailing MAILING_ID=<tuoid>'.."
task :send_mailing => :environment do
  puts "rake send_mailing con note: '#{ yellow ENV["COMMENT"] }'"
  @mailing = Mailing.find(ENV["MAILING_ID"])
  @mailing.deliver
end



desc "Send mailing attraverso 'rake send_mailing MAILING_ID=<tuoid>'.."
task :send_closest_pubs => :environment do
  puts "TBD Send email to user <USER_ID> with closest pubs and events where he/she is :)"
end