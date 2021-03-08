class Ad < Sequel::Model
  plugin :validation_helpers
  db.extension(:pagination)

  # Как получить пагинацию
  # Ad.db[:ads].paginate(2, 2).last_page?

  def validate
    super
    validates_presence [:title, :description, :city, :user_id]
  end
end
