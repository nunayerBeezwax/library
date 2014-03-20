class Book
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes['title']
  end

  def self.all
    results = DB.exec("SELECT * FROM books")
    books = []
    results.each do |i|
      title = i['title']
      books << Book.new({'title' => title})
    end
    books
  end

  def save(copies)
    results = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = results.first['id'].to_i
    copies.times { DB.exec("INSERT INTO copies (book_id) VALUES (#{@id});") }
  end

  def self.delete(title)
    result = DB.exec("SELECT id FROM books WHERE title = '#{title}';")
    id = result.first['id'].to_i
    DB.exec("DELETE FROM books WHERE id = '#{id}';")
    DB.exec("DELETE FROM books_authors WHERE books_authors.book_id = '#{id}';")
  end

  def self.search(arg)
    x = ''
    Book.all.each do |book|
      if book.title == arg
        x = book.title
      end
    end
    x
  end


  def Book.clear
    @books = []
  end

  def ==(another_book)
    self.title == another_book.title
  end
end
