class ConceptGenerator < Rails::Generators::NamedBase
  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  # https://api.rubyonrails.org/classes/Rails/Generators/NamedBase.html
  def generate
    p(name:)
    p(attributes: attributes.join(" "))
    p(file_name:)
    p(class_name:)
    p(options:)
    # rails_command
  end
end
