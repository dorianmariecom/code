require 'rails_helper'

RSpec.feature "GenerateAndEvaluateProgram" do
  it "works" do
    visit root_path

    fill_in "Prompt", with: "Arithmetics" # input: 1 + 1

    click_on "Generate"

    click_on "Evaluate"

    assert_text "result\n2"
  end
end
