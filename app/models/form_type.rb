class FormType
  AUTOCOMPLETE_TO_FORM_TYPE = {
    off: :other,
    email: :email,
    phone: :phone,
    name: :name,
    "new-password": "password,new",
    "current-password": "password"
  }

  attr_reader :autocomplete

  def initialize(autocomplete)
    @autocomplete = autocomplete.to_sym
  end

  def self.from(autocomplete)
    new(autocomplete).from
  end

  def from
    AUTOCOMPLETE_TO_FORM_TYPE.fetch(autocomplete)
  end
end
