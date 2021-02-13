module SaveLoadHelper
  def save_to_db(stats)
    File.open(File.expand_path('top_users.yml', 'db'), 'w') { |file| file.write(stats.to_yaml) }
  end

  def load_from_db
    if File.exist?('./db/top_users.yml')
      File.open(File.expand_path('top_users.yml', 'db')) do |file|
        YAML.safe_load(file, [Stats], [], true)
      end
    else
      []
    end
  end
end
