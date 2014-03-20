class Books_authors
  attr_reader :book_id, :author_id

  def initialize(attributes)
    @book_id = attributes['book_id']
    @author_id = attributes['author_id']
  end

  def save
    DB.exec("INSERT INTO books_authors (book_id, author_id)
                      VALUES (#{@book_id}, #{author_id});")
  end
end
