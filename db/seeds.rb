#!/usr/bin/env ruby

(config = Rails.application.credentials.apple)
  .applications
  .each do |application|
  config.environments.each do |environment|
    print "#{application[:name]} | #{application[:bundle_id]} | #{environment}... "
    if Rpush::Apnsp8::App.find_by(
         name: application[:name],
         environment: environment
       )
      puts "skipping"
    else
      app = Rpush::Apnsp8::App.new
      app.name = application[:name]
      app.apn_key = config.apn_key
      app.environment = environment
      app.apn_key_id = config.apn_key_id
      app.team_id = config.team_id
      app.bundle_id = application[:bundle_id]
      app.save!
      puts "done"
    end
  end
end

Page::DOCUMENTATION.each do |parent|
  parent_slug = parent["slug"] || parent["title"].parameterize
  parent_page =
    Page.create!(
      title: parent["title"],
      slug: parent_slug,
      body: parent["body"]
    )
  puts "new page: #{parent["title"]}"

  parent["children"].each do |child|
    child_slug = child["slug"] || child["title"].parameterize
    child_body = "<p>#{child["body"]}</p>"
    child["arguments"].each do |name, argument|
      child_body += "<p><b>#{name}</b> (#{argument["type"]}): "
      child_body += "optional, " if argument["optional"]
      child_body += "required, " if argument["required"]
      child_body +=
        "#{argument["description"]}, defaults to #{argument["default"]}"
      child_body += "</p>"
    end
    child_body += "<p>returns: #{child["return"]}</p>"
    Page.create!(
      title: "#{parent["title"]}##{child["title"]}",
      slug: "#{parent_slug}_#{child_slug}",
      body: child_body,
      page: parent_page
    )
    puts "new page #{parent["title"]}##{child["title"]}"
  end
end
