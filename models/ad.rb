class Ad < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:title, :description, :city, :user_id]
  end

  dataset_module do
    def page(offset, limit)
      paginate(offset, limit)
    end
  end
end
