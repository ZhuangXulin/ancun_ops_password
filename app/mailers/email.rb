class Email < ApplicationMailer
  FORM = 'zhuangxulin@ancun.com'
  URL = 'http://xxx:3000/'

  def login_email(email,remote_ip)
  	@url  = URL
  	@remote_ip = remote_ip
  	@time = Time.now
    mail( :subject => 'User sucessful login in OPS password manager system',   
          :to => email,  
          :from => FORM,   
          :date => Time.now  
        ) 
  end

  def login_unsucessful_email(email,remote_ip)
    @url  = URL
    @remote_ip = remote_ip
    @time = Time.now
    mail( :subject => 'User uncessful login in OPS password manager system',   
          :to => email,  
          :from => FORM,   
          :date => Time.now  
        ) 
  end

end
