# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  date_of_birth          :date
#  phone                  :string
#  cell_phone             :string
#  photo_file_name        :string
#  photo_content_type     :string
#  photo_file_size        :integer
#  photo_updated_at       :datetime
#  neighborhood           :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable

  has_many :user_neighborhoods
  # TODO: Remove neighborhood model
  has_many :neighborhoods, through: :user_neighborhoods

  has_many :user_groups
  has_many :groups, through: :user_groups do
    def leader_of
      where("user_groups.is_leader = ?", true)
    end
  end

  def is_leader(group)
    group.users.leaders.exists?(id: id)
  end

  has_many :posts, dependent: :destroy

  validates :email, presence: true

  has_attached_file :photo, :styles => { :medium => "500x500>", :thumb => "150x150#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /^image\/(png|gif|jpeg|jpg)/
end
