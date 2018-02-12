class ZipCode < ApplicationRecord
  validates :zip_code,
            presence: true,
            format: {
              with: /\A\d{5}\z/,
              message: 'not a valid zip code',
              allow_nil: true
            }
end
