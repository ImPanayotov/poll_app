# frozen_string_literal: true

class PollPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user&.admin?
  end

  def create?
    user&.admin?
  end

  def edit?
    user&.admin?
  end

  def update?
    user&.admin?
  end

  def destroy?
    user&.admin?
  end

  def destroy_all?
    user&.admin?
  end

  def create_vote?
    !user&.admin?
  end
end
