# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :datetime
#  color       :string(255)
#  name        :string(255)
#  sex         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Cat < ActiveRecord::Base
  # validates :birth_date, timeliness: { on_or_before: Date.current }
  COLORS = ['black', 'white', 'brown', 'calico', 'orange']
  SEX = ['M', 'F']
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: SEX}
  validates :name, :presence => true
  has_many(:cat_rental_requests,
  :dependent => :destroy)
  
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def age
    Date.current.year - birth_date.year
  end
end
