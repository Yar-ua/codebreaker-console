module SaveLoadHelper
  def save_to_db(stats, db_file)
    File.open("./db/#{db_file}", 'w') { |file| file.write(stats.to_yaml) }
  end

  def load_from_db(db_file)
    if File.exist?("./db/#{db_file}")
      File.open("./db/#{db_file}") do |file|
        YAML.safe_load(file, [Stats], [], true)
      end
    else
      []
    end
  end
end
