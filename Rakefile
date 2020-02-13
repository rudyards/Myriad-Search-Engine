require "pathname"
require "fileutils"

def db
  @db ||= begin
    require_relative "search-engine/lib/card_database"
    CardDatabase.load
  end
end

task "default" => "spec"
task "test" => "spec"

# Run specs
task "spec" do
  Dir.chdir("search-engine") do
    sh "rspec"
  end
  Dir.chdir("frontend") do
    sh "rake test"
  end
end

desc "Generate index"
task "index" do
  sh "./indexer/bin/indexer"
end

desc "Update mtgjson database"
task "mtgjson:fetch" do
  unless Pathname("AllSets.json").exist?
    sh "wget", "https://www.mtgjson.com/json/AllSets.json"
  end
  if Pathname("data/sets-incoming").exist?
    sh "trash", "data/sets-incoming"
  end
  sh "./indexer/bin/split_mtgjson", "./AllSets.json", "data/sets-incoming"
  sh "./indexer/bin/update_mtgjson_sets"
end

desc "Fetch new mtgjson database and update index"
task "mtgjson:update" => ["mtgjson:fetch", "index"]


desc "Fetch Myriad pics"
task "pics:myriad" do
  pics = Pathname("frontend/public/cards")
  db.printings.each do |c|
    next unless c.multiverseid
    if c.layout == "split"
      tempNumber = c.number.gsub(/[ab]/, "")
    else
      tempNumber = c.number
    end
    path = pics + Pathname("#{c.set_code}/#{tempNumber}.jpg")
    path.parent.mkpath
    next if path.exist?
    url = "https://myriadmtg.000webhostapp.com/images/#{c.set_code}/#{tempNumber}.jpg"
    puts "Downloading #{c.name} #{c.set_code} #{c.multiverseid}"
    puts "   from #{url.to_s}"
    puts "   to #{path.to_s}"
    command = "wget -nv -nc #{url} -O #{path}"
    #puts "   command: #{command}"
    system "wget", "-nv", "-nc", url, "-O", path.to_s
  end
end

desc "Fetch Gatherer pics"
task "pics:gatherer" do
  pics = Pathname("frontend/public/cards")
  db.printings.each do |c|
    next unless c.multiverseid
    path = pics + Pathname("#{c.set_code}/#{c.number}.png")
    path.parent.mkpath
    next if path.exist?
    url = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{c.multiverseid}&type=card"
    puts "Downloading #{c.name} #{c.set_code} #{c.multiverseid}"
    system "wget", "-nv", "-nc", url, "-O", path.to_s
  end
end

desc "Connect links to HQ pics"
task "link:pics" do
  Pathname("frontend/public/cards_hq").mkpath
  if ENV["RAILS_ENV"] == "production"
    sources = Dir["/home/rails/magic-card-pics-hq-*/*/"]
  else
    sources = Dir["#{ENV['HOME']}/github/magic-card-pics-hq-*/*/"]
  end
  sources.each do |source|
    source = Pathname(source)
    set_name = source.basename.to_s
    target_path = Pathname("frontend/public/cards_hq/#{set_name}")
    next if target_path.exist?
    # p [target_path, source]
    target_path.make_symlink(source)
  end
end

desc "Fetch HQ pics"
task "pics:hq" do
  sh "./bin/fetch_hq_pics"
end

desc "Save HQ pics hashes"
task "pics:hq:save" do
  sh "./bin/save_hq_pics_hashes"
end

desc "Print basic statistics about card pictures"
task "pics:statistics" do
  sh "./bin/pics_statistics"
end

desc "List cards without pictures"
task "pics:missing" do
  sh "./bin/cards_without_pics"
end

desc "Clanup Rails files"
task "clean" do
  [
    "frontend/Gemfile.lock",
    "frontend/log/development.log",
    "frontend/log/production.log",
    "frontend/log/test.log",
    "frontend/tmp",
    "search-engine/.respec_failures",
    "search-engine/coverage",
    "search-engine/Gemfile.lock",
  ].each do |path|
    system "trash", path if Pathname(path).exist?
  end
  Dir["**/.DS_Store"].each do |ds_store|
    FileUtils.rm ds_store
  end
end

desc "Fetch new Comprehensive Rules"
task "rules:update" do
  sh "bin/fetch_comp_rules"
  sh "bin/format_comp_rules"
end

desc "Full update"
task "update" do
  Rake::Task["rules:update"].invoke
  Rake::Task["mtgjson:fetch"].invoke
  Rake::Task["index"].invoke
  sh "~/github/magic-preconstructed-decks/bin/build_jsons ./decks.json"
  sh "./deck_indexer/bin/deck_indexer"
  sh "./bin/export_sealed_data  ~/github/magic-sealed-data"
  sh "./bin/export_decks_data  ~/github/magic-preconstructed-decks-data/decks.json"
  # sh "trash ./decks.json"
  # sh "trash ./AllSets.json"
end
