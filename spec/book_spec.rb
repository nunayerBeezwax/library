require 'rspec'
require 'book'
require 'copies'
require 'pg'
require 'pry'

DB = PG.connect(:dbname => 'library_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM copies *;")
  end
end

describe 'Book' do
  describe 'initialize' do
    it 'initializes a book object with a title' do
      test_book = Book.new({ 'title' => "Finnegans Wake"})
      test_book.should be_an_instance_of Book
      test_book.title.should eq "Finnegans Wake"
    end
  end
    describe 'save' do
      it 'lets you save a book to the library' do
      test_book = Book.new({ 'title' => "Finnegans Wake"})
      test_book.save(1)
      Book.all.should eq [test_book]
    end
      it 'inserts the appropriate number of book ids into copies table' do
        test_book = Book.new({ 'title' => "Finnegans Wake"})
        test_book.save(10)
        Copy.all.length.should eq 10
      end

    describe '.delete' do
      it 'lets you delete a book' do
      test_book1 = Book.new({ 'title' => "Moby Dick"})
      test_book1.save(1)
      test_book2 = Book.new({ 'title' => "The Great Gatsby"})
      test_book2.save(1)
      Book.delete("Moby Dick")
      Book.all.should eq [test_book2]
    end
  end
  describe '.search' do
    it 'searches the library by title' do
      test_book = Book.new({ 'title' => "The Great Gatsby"})
      test_book.save(1)
      Book.search("The Great Gatsby").should eq test_book.title
    end
  end
end

end
