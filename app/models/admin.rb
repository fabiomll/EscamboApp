class Admin < ActiveRecord::Base

  ROLES = {:full_access => 0, :restricted_access => 1}
  enum role: ROLES

  #enum role: [:full_access, :restrict_access]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  ##### NAO USA MAIS, AGORA USA O ENUM_I18N ############
  # def role_br
  #   if self.role == "full_access"
  #     "Acesso Completo"
  #   else
  #     "Acesso Restrito"
  #   end
  # end

  ##############ESCOPO AULA 133 #################
  # scope :with_full_acees, -> {where(role: 'full_access') }
  scope :with_full_acees, -> {where(role: 0) }
  scope :with_restricted_access, -> {where(role: 1) }

  # def self.with_full_aceess
  #   where(role: 'full_access')
  # end
  #########################################

end
