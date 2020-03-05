class CatRentalRequest < ApplicationRecord
    validates :cat_id, :start_date, :end_date, presence: true
    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
    validate :does_not_overlap_approved_request

    belongs_to :cat,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :Cat

    # private
    def overlapping_requests
        CatRentalRequest
            .where(cat_id: self.cat_id)
            .where.not(id: self.id)
            .where('start_date >= ? AND start_date <= ?', self.start_date, self.end_date)
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: "APPROVED")
    end

    def does_not_overlap_approved_request
        overlapping_approved_requests.exists?
    end

    def overlapping_pending_requests
        overlapping_requests.where(status: "PENDING")
    end
end