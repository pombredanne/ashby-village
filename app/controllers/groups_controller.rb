class GroupsController < ApplicationController
  before_filter :auth_user!
  autocomplete :user, :full_name, full: true
  autocomplete :group, :name, { full: true }

  def autocomplete_group_name
    term = params[:term].downcase
    neighborhood = Group.neighborhoods[params[:neighborhood].gsub("^", " ")] || "all"
    if neighborhood == "all"
      groups = Group.active.where('lower(name) LIKE ?', "%#{term}%").order(:name).all
    else
      groups = Group.active.where('neighborhood = ? AND lower(name) LIKE ?', neighborhood, "%#{term}%").order(:name).all
    end
    render json: groups.map { |g| {id: g.id, label: g.name, value: g.name} }
  end

  # TODO(Shimmy): Only display this page if the user is logged in
  def index
    # TODO(Shimmy):Make scopes for these
    @groups = Group.active
    @neighborhoods = Group.neighborhoods.keys
    my = params[:format]
    if my.nil?
      @all = "selected = \"selected\"".html_safe
      @my = "".html_safe
    else
      @my = "selected = \"selected\"".html_safe
      @all = "".html_safe
    end
  end

  def my_index
    @groups = current_user.groups.active
  end

  def show
    @post = Post.new
    @reply = Reply.new
    @group = Group.friendly.find(params[:id])
    @posts = @group.posts.where(event_id: nil).order_by_created_at
    @event_id = nil
    @group_id = @group.id
    @neighborhood = @group.neighborhood
  end

  def new
    if current_user
      if params.key?(:group_param)
        @group = Group.new(params[:group_param].permit(:name, :description, :neighborhood))
      else
        @group = Group.new
      end
      @neighborhoods = Group.neighborhoods.keys
      @allnames = Group.all.map(&:name)
      render action: "new", notice: "Sample notice"
    else
      redirect_to new_user_session_path, notice: "You are not logged in."
    end
  end

  # When User creates group, create a UserGroup with is_leader: true
  def create
    @group = Group.new(group_params)
    if @group.save
      if !params[:selected_leaders].blank?
        @users = User.find(params[:selected_leaders].split(","))
        if !@users.include?(current_user)
          @group.add_user(current_user, make_leader = true)
        end
        @users.each do |user|
          @group.add_user(user, make_leader = true)
        end
      else # remember to always add current user as leader
        @group.add_user(current_user, make_leader = true)
      end
      redirect_to @group, notice: "Group was successfully created."
    else
      @neighborhoods = Group.neighborhoods.keys
      redirect_to action: "new", group_param: group_params
    end
  end

  def member_listing
    @group = Group.friendly.find(params[:id])
  end

  def join
    @group = Group.find(params[:id])
    flash[:notice] = "Successfully joined #{@group.name}"
    if not @group.users.include?(current_user)
      @group.add_user(current_user)
      redirect_to @group
    else
      redirect_to :back
    end
  end

  def leave
    @group = Group.find(params[:id])
    @group.remove_user(current_user)
    flash[:notice] = "You have successfully left the group"
    if @group.inactive?
      redirect_to groups_path
    else
      redirect_to :back
    end
  end

  def edit
    @group = Group.friendly.find(params[:id])
    @users = User.where.not(id: @group.users.leaders.pluck(:id)).decorate.map{ |u| [u.full_name, u.id]}
    @neighborhoods = Group.neighborhoods.keys
  end

  def update
    @group = Group.friendly.find(params[:id])
    if @group.update_attributes(group_params)
      @group.users.leaders.each do |user|
        @group.remove_user(user)
      end
      if !params[:selected_leaders].blank?
        params[:selected_leaders].split(",").each do |slid|
          @group.add_user(User.find(slid.to_i), make_leader = true)
        end
        @group.update_attribute(:state, Group.states["active"])
      end
      flash[:notice] = "Group updated!"
      redirect_to group_path
    else
      flash[:alert] = "Unable to update group."
      redirect_to :back
    end
  end

  def notifications
    @group = Group.friendly.find(params[:id])
    @user_group = current_user.user_groups.where(group_id: @group.id).first
    if @user_group && @user_group.group_email_notifications == true
      @email_notif = @user_group.group_email_notifications
      if current_user.user_groups.where(group_id: @group.id).first.update_attribute(:group_email_notifications, false)
        flash[:notice] = "Your email notifications for this group are now off."
        redirect_to group_path
      end
    elsif @user_group && @user_group.group_email_notifications == false
      @email_notif = @user_group.group_email_notifications
      if current_user.user_groups.where(group_id: @group.id).first.update_attribute(:group_email_notifications, true)
        flash[:notice] = "Your email notifications for this group are now on."
        redirect_to group_path
      end
    else
      flash[:notice] = "Email notifications for this group could not be updated."
      redirect_to group_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :neighborhood, :photo)
  end

end
