module SerchableTag
  extend ActiveSupport::Concern

  included do

    def self.match_tag(term)
      if term.present?
        rank = <<-RANK
        ts_rank(to_tsvector(description), plainto_tsquery(#{sanitize(term)}))
      RANK
      where("description ilike :q", q: "%#{term}%").order("#{rank} desc")
      else
        limit(10)
      end
    end
  end
end