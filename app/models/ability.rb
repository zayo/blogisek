class Ability
  include CanCan::Ability

  def initialize(user)

    if user.nil?
      cannot :manage, :all
      can :read, Post, :is_private => false
      can [:read, :create], Pcomment, :approved => true
      can [:read, :create], Ccomment, :approved => true
    elsif user.has_role? :admin
      can :manage, :all
    else
      cannot :manage, :all
      can [:read, :create], Post
      can [:update, :destroy], Post, :user_id => user.id



      can [:read, :create], Pcomment, :approved => true
      can [:read, :create], Ccomment, :approved => true

      can [:read, :update, :destroy], Pcomment, :post => {:user_id => user.id}
      can [:read, :update, :destroy], Ccomment, :post => {:user_id => user.id}

      can [:destroy], Pcomment, :user_id => user.id
      can [:destroy], Ccomment, :user_id => user.id
    end
  end
end
