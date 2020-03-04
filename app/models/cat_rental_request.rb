class CatRentalRequest < ApplicationRecord
    validates :cat_id, :start_date, :end_date, presence: true
    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }

    belongs_to :cat,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :Cat
end