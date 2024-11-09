# frozen_string_literal: true

require "rails_helper"

RSpec.feature "GenerateAndEvaluateProgram" do
  it "works" do
    visit root_path

    fill_in "input", with: "1 + 1"

    click_on "create"

    click_on "evaluate"

    assert_text "result\n2"
  end
end
