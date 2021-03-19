class Ad < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    [:title, :description, :city, :user_id].each do |attr|
      validates_presence attr, message: I18n.t("models.ad.attributes.#{attr}.blank")
    end
  end

  dataset_module do
    def page(offset, limit)
      paginate(offset, limit)
    end
  end
end
