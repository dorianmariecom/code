class Page < ApplicationRecord
  DOCUMENTATION =
    YAML.safe_load(File.read(Rails.root.join("config/documentation.yml")))

  SPECIAL_CHARACTERS = {
    "." => "dot",
    "÷" => "division",
    "@" => "at",
    "#" => "hash",
    "$" => "dollar",
    "%" => "percent",
    "^" => "caret",
    "&" => "and",
    "*" => "asterisk",
    "(" => "left_parenthesis",
    ")" => "right_parenthesis",
    "+" => "plus",
    "=" => "equals",
    "{" => "left_brace",
    "}" => "right_brace",
    "[" => "left_bracket",
    "]" => "right_bracket",
    ":" => "colon",
    ";" => "semicolon",
    '"' => "double_quote",
    "'" => "single_quote",
    "<" => "less_than",
    ">" => "greater_than",
    "?" => "question_mark",
    "/" => "forward_slash",
    "\\" => "backslash",
    "|" => "vertical_bar",
    "`" => "backtick",
    "~" => "tilde",
    "!" => "exclamation_mark"
  }

  belongs_to :page, touch: true, optional: true

  validates :title, presence: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true
  has_many :pages, dependent: :destroy

  before_validation do
    self.slug ||= title

    SPECIAL_CHARACTERS.each do |special, word|
      self.slug.gsub!(special, "-special-#{word}-")
    end

    self.slug.gsub!(/-+/, "-")

    self.slug = slug.parameterize
  end

  def to_param
    slug
  end

  def to_s
    title
  end
end
