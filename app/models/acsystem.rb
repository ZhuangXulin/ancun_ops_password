class Acsystem < ActiveRecord::Base
  validates :system_name, presence: true
  validates :system_password, presence: true

  self.per_page = 15
	#获取客户列表
  def self.get_system_password_list(operator_id,search_key,page)
    #Customer.paginate_by_sql("select * from customers ",:page => page, :per_page => per_page)
    Acsystem.where("system_name like ?","%#{search_key}%").paginate(:page => page, :per_page => per_page)
  end

  def self.create(system_info)
    password_salt = self.new_salt(16)
  	Acsystem.new(
  			:system_name => system_info['system_name'],
  			:system_desc => system_info['system_desc'],
  			:system_ip => system_info['system_ip'],
  			:system_password => Base64.encode64(system_info['system_password']+'fuck this is the password salt'+password_salt),
        :system_password_salt => password_salt
  		)
  end

  def self.show(system_id)
    acsystem_info = Acsystem.find(system_id)
  end

  private
    def self.new_salt(len)
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      new_salt = ""
      1.upto(len) { |i| new_salt << chars[rand(chars.size-1)] }
      return new_salt
    end
end