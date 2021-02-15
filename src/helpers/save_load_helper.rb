module SaveLoadHelper
  def save_to_db(stats, db_file)
    File.open("./db/#{db_file}", 'w') { |file| file.write(stats.to_yaml) }
  end

  def load_from_db(db_file)
    return [] unless File.exist?("./db/#{db_file}")

    File.open("./db/#{db_file}") do |file|
      YAML.safe_load(file, [Stats], [], true)
    end
  end
end
