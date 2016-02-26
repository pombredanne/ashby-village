require "rails_helper"

# create anything you want to reuse that is NOT what you're testing
post_content = "rspec post content"
u1 = User.create first_name: "Rspec first name",\
                 last_name: "Rspec last name",\
                 email: "rspec@gmail.com",\
                 password: "rspecpassword",\
                 password_confirmation: "rspecpassword",\
                 role: 0
g1 = Group.create name: "Rspec Group",\
                  description: "Rspec Description",\
                  neighborhood: 1,\
                  kind: 0,\
                  state: 1

RSpec.describe Post, type: :model do
  it "is valid" do
    p1 = Post.new(user_id: u1.id, content: post_content, group_id: g1.id)
    expect(p1.save).to eq true
    expect(Post.first).to eq p1
    expect(p1.content).to eq post_content
  end
  it "is invalid without an id" do
    p1 = Post.new(content: post_content, group_id: g1.id)
    expect(p1.save).to eq false
  end
  it "is invalid without content" do
    p1 = Post.new(user_id: u1.id, group_id: g1.id)
    expect(p1.save).to eq false
  end
  it "is invalid without a group" do
    p1 = Post.new(user_id: u1.id, content: post_content)
    expect(p1.save).to eq false
  end
  it "is ordered by most recent first"

  # Here is where you put clean up for everything you created at the top
  after(:all) do
    if Rails.env.test?
      u1.destroy
      g1.destroy
    end
  end
end
