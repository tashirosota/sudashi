require 'carrierwave/orm/activerecord'
class SudachiImage < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
end
