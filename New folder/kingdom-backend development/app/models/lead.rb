# frozen_string_literal: true

class Lead < ApplicationRecord
  belongs_to :user
  enum stage: { prospecting: 0, contacted: 1, demo: 2, followup: 3, closing: 4 }
  enum heat: { cold: 0, warm: 1, hot: 2 }

  validates :first_name, presence: true
  validates :phone_number, uniqueness: true,
                           presence: true
  #  This validation for US numbers
  validates :phone_number,
            format: { with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/,
                      message: 'Invalid phone number' }

  scope :search, ->(query) { where('first_name ILIKE ? OR last_name ILIKE ?', "%#{query}%", "%#{query}%") }

  require 'csv'

  # user should be deleted after adding the functionality for user to sign-in
  def self.import(user, path)
    CSV.foreach(path, headers: true,
                      skip_blanks: true,
                      skip_lines: /^(?:,\s*)+$/) do |row|
      new_hash = {}
      row.to_hash.each_pair do |k, v|
        new_hash.merge!({ k.downcase => v })
        next if new_hash['phone_number'].nil?
      end
      user.leads.create(new_hash)

      p new_hash
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.last_created
    where('created_at >= ?', 10.minutes.ago)
  end
end
