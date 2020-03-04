class CatRentalRequest < ApplicationRecord
    validates :cat_id, :start_date, :end_date, presence: true
    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }

    belongs_to :cat,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :Cat

    def overlapping_requests
        CatRentalRequest
            .where(cat_id: self.cat_id)
            .where.not(id: self.id)
            .where('start_date >= ? AND start_date <= ?', self.start_date, self.end_date)
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: "APPROVED")
    end
end