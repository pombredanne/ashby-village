# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  starttime   :time
#  endtime     :time
#  startdate   :date
#  enddate     :date
#  group_id    :integer
#  location    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  gmap        :boolean          default(FALSE)
#  capacity    :integer
#

require "rails_helper"

RSpec.describe Event, type: :model do
  before do
    @g1 = Group.create name: "Rspec Group",
                       description: "Rspec Description",
                       neighborhood: 1,
                       state: 1
    @g1 = Group.find_by(name: "Rspec Group")
  end
  it "is valid" do
    e = Event.new(title: "Test Event",
                  group_id: @g1,
                  description: "This is a super cool test event where people should come and yay!",
                  location: "Berkeley, CA",
                  starttime: "2:00pm",
                  endtime: "3:00pm",
                  startdate: "1-5-16",
                  enddate: "1-5-16")
    expect(e.valid?).to eq true
  end
end
