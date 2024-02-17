class ConceptGenerator < Rails::Generators::NamedBase
  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  # https://api.rubyonrails.org/classes/Rails/Generators/NamedBase.html
  def generate
    rails_command("generate model #{class_name} #{attributes.join(" ")}")
  end
end
