# frozen_string_literal: true

class VotePolicy < ApplicationPolicy
  def create?
    !user&.admin?
  end
end
