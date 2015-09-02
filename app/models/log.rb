class Log < ActiveRecord::Base
  belongs_to :user

  validates :sys_module, :action, :actor_id, presence: true

end
