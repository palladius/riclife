class Notifier < ActionMailer::Base
  #import ColorsHelper
  
# scopiazzato da qui: http://github.com/openrain/action_mailer_tls

  def bella_ric_prova_gmail(opts=nil)
    mail_body = opts[:body] || <<-DFLT_MAIL_BODY

Hi bellaric, tu sei #{user rescue 'UNKNOWN_USER'}.
Nonetheless, ti voglio bene. TBD crea utente riclife.

  DFLT_MAIL_BODY
    sent_at = opts[:sent_at] || Time.now
    subject = opts[:subject] || 'Notifier: Bella Ric, prova da GMail!'
    to = opts[:to] || 'palladiusbonton@gmail.com'
    from = opts[:from] || 'RuscoRic Daemon'
    content_type "text/html" # by default :P
    
    subject    "[RicLife] #{subject}"
    recipients to
    from       'Rusco Ric'
    sent_on    sent_at
    #html       true
    
    body       :greeting => mail_body

    puts(ColorsHelper.yellow("Trying to send email ('#{subject}') to: #{to}"))
    #puts(("Trying to send email ('#{subject}') to: #{to}"))
  end

  # per far funzionare il tutorial a prova di imbecilli!
  alias :hello_world :bella_ric_prova_gmail

  # per farlo andare, digita in console:


end
