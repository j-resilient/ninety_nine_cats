class CatRentalRequest < ApplicationRecord
    validates :cat_id, :start_date, :end_date, presence: true
    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
    validate :does_not_overlap_approved_request

    belongs_to :cat,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :Cat

    def approve!
        # transaction makes sure that if either of these lines raises an error, 
        # neither is permanently saved to the database
        # aka making sure it's all one transaction
        # update_attributes! takes a hash, changes the given attribute, and then calls save!
        # which will raise an error if something goes wrong
        ActiveRecord::Base.transaction do
            self.update_attributes!(status: "APPROVED")
            overlapping_pending_requests.map { |request| request.update_attributes!(status: "DENIED") }
        end
    end

    def deny!
        self.update_attributes(status: "DENIED")
    end

    def pending?
        self.status == "PENDING"        
    end

    private
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
        if overlapping_approved_requests.exists?
            errors[:overlapping] << "request already approved"
        end
    end

    def overlapping_pending_requests
        overlapping_requests.where(status: "PENDING")
    end

end