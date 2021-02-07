module SaveLoadHelper

  def save_to_db(winner)
    File.open(File.expand_path('top_users.yml', 'db'), 'a') { |file| file.write(to_yaml) }
  end

  # def load_file(file_name)
  #   File.open(File.expand_path(file_name, 'db')) { |file| YAML.safe_load(file, [Library, Author, Book, Reader, Order, Date], [], true) }
  # end
end
