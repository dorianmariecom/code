class Page < ApplicationRecord
  DOCUMENTATION =
    YAML.safe_load(File.read(Rails.root.join("config/documentation.yml")))

  belongs_to :page, touch: true, optional: true

  validates :title, presence: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end

  def to_s
    title
  end
end
