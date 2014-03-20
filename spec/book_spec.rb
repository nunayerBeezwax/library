require 'rspec'
require 'book'

describe 'Book' do
  describe 'initialize' do
    it 'initializes a book object with a title and author' do
      test_book = Book.new("James Joyce", "Finnegan's Wake")
      test_book.should be_an_instance_of Book
      test_book.author.should eq "James Joyce"
      test_book.title.should eq "Finnegan's Wake"
    end
  end
end
