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

def create_pages(doc, parent: nil, type: nil)
  if doc[:type] == "class"
    if parent
      page =
        Page.create!(
          page: parent,
          title: "#{parent.title}::#{doc[:name]}",
          body: "class"
        )
    else
      page = Page.create!(title: doc[:name], body: "class")
    end

    doc
      .fetch(:class_functions, [])
      .each do |instance_doc|
        create_pages(instance_doc, parent: page, type: :class_function)
      end

    doc
      .fetch(:instance_functions, [])
      .each do |instance_doc|
        create_pages(instance_doc, parent: page, type: :instance_function)
      end
  elsif parent && doc[:type] == "function" && type == :instance_function
    Page.create!(
      page: parent,
      title: "#{parent.title}##{doc[:name]}",
      body: "instance function"
    )
  elsif parent && doc[:type] == "function" && type == :class_function
    Page.create!(
      page: parent,
      title: "#{parent.title}.#{doc[:name]}",
      body: "class function"
    )
  elsif parent && doc[:type] == "function"
    Page.create!(page: parent, title: doc[:name], body: "function")
  elsif doc[:type] == "function"
    Page.create!(title: doc[:name], body: "function", slug: "global-function-#{doc[:name]}")
  else
    raise NotImplementedError
  end
end

Page.destroy_all
Page::DOCUMENTATION.each { |doc| create_pages(doc.deep_symbolize_keys) }
