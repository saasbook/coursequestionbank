class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    can [:read], Problem, :access_level => 1
    can [:read], Collection, :access_level => 1

    if user.get_privilege == "Admin"
      can :manage, :all

    end

    if user.get_privilege == "Instructor"
      can :manage, Problem, :instructor_id => user.id
      can [:read, :update, :supersede, :view_history, :add_tags, :remove_tags, :bloom_categorize], Problem, :access_level => 2
      can [:read, :update, :supersede, :view_history, :add_tags, :remove_tags, :bloom_categorize], Problem, :access_level => 1
      can :add_to_collection, Problem
      can :see_answer, Problem
      can :manage, Collection, :instructor_id => user.id
      can [:read, :export, :preview], Collection, :access_level => 2
      can [:read, :export, :preview], Collection, :access_level => 1
      can :create, Collection
    end

  end
end
