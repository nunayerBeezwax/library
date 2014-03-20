class Copy
  attr_reader :book_id

  def initialize(attributes)
    @book_id = attributes[:book_id]
  end

  def self.all
    results = DB.exec("SELECT * FROM copies")
    book_ids = []
    results.each do |i|
      book_id = i['book_id']
      book_ids << Copy.new({'book_id' => book_id})
    end
    book_ids
  end

  def Copy.clear
    @book_ids = []
  end
end
