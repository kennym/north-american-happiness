class Record < ActiveRecord::Base
  before_create :set_default_date
  def set_default_date
    self.date ||= Time.now
  end
end
