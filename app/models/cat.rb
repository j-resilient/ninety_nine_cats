class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper
    CAT_COLORS = ['black', 'white', 'orange', 'brown']

    validates :name, :birth_date, :color, :sex, presence: true
    validates :color, inclusion: {
        in: CAT_COLORS,
        message: "not a cat color."
    }
    validates :sex, inclusion: {
        in: %w(M F),
        message: "must be M or F."
    }

    def age
        time_ago_in_words(self.birth_date)
    end
end