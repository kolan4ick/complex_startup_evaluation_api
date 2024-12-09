# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  adjustment_delta       :float            default(0.1), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  jti                    :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :evaluations, dependent: :destroy

  has_many :feasibility_levels, dependent: :destroy
  accepts_nested_attributes_for :feasibility_levels

  after_create :create_feasibility_levels

  validates :adjustment_delta, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1 }
  before_update :create_or_validate_feasibility_levels

  private

  # Ensures the user has exactly five feasibility levels before updating.
  def create_or_validate_feasibility_levels
    # Access in-memory feasibility_levels (with any pending changes)
    current_feasibility_levels = feasibility_levels.target

    # Create any missing levels if necessary
    create_missing_feasibility_levels(current_feasibility_levels)

    # Ensure all linguistic keys are present and unique
    linguistic_keys = current_feasibility_levels.map(&:linguistic).sort
    return unless current_feasibility_levels.size != 5 || linguistic_keys != FeasibilityLevel.linguistics.keys.sort

    errors.add(:feasibility_levels, 'should consist of exactly five levels with all required linguistic keys')
    throw(:abort)
  end

  # Creates missing feasibility levels in memory if any are absent.
  def create_missing_feasibility_levels(current_feasibility_levels)
    existing_levels = current_feasibility_levels.map(&:linguistic)
    missing_levels = FeasibilityLevel.linguistics.keys - existing_levels

    missing_levels.each do |level|
      feasibility_levels.build(linguistic: level, value: 0.1, title: level.to_s.humanize)
    end
  end

  def create_feasibility_levels
    FeasibilityLevel.linguistics.each_key.with_index(1) do |level, index|
      feasibility_levels.create!(linguistic: level, value: 0.1, title: level.to_s.humanize, order: index)
    end
  end
end
