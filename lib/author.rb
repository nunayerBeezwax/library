class Author
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

    def self.all
    results = DB.exec("SELECT * FROM authors")
    authors = []
    results.each do |i|
      name = i['name']
      id = i['id']
      authors << Author.new({'name' => name, 'id' => id })
    end
    authors
  end

  def duplicate(author)
    author_id = ''
    Author.all.each do |i|
      if i['name'] == author
        author_id = i['id']
      end
    end
    if author_id != ''
     new_author = Author.new({'name' => author})
      new_author.save
      author_id = new_author.id
    end
  end

  def self.search(string)
    x = ''
    Author.all.each do |author|
      if author.name == string
        x = author.name
      end
    end
    x
  end

  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end
end
