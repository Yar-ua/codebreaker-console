module SaveLoadHelper
  DB_DIR = './db/'.freeze

  def save_to_db(stats, db_file)
    File.open(DB_DIR + db_file, 'w') { |file| file.write(stats.to_yaml) }
  end

  def load_from_db(db_file)
    return [] unless File.exist?(DB_DIR + db_file)

    File.open(DB_DIR + db_file) { |file| YAML.load(file) }
  end
end
