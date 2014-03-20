require 'pg'
require './lib/book'
require './lib/author'
require './lib/books_authors'
require 'pry'
DB = PG.connect(:dbname => 'library')

def main

  puts "\nMAIN MENU",
       "1: Librarian Access",
       "2: Library Patron Access",
       "3: Exit"
  print ">>"

  choice = gets.chomp

  case choice
  when '1'
    librarian_menu
  when '2'
    patron_menu
  when '3'
    puts "Bye!!"
  end
end

def librarian_menu
  puts "Librarian Portal",
       '-'*30,
       "Press 'B' to add a new book to the Library",
       "Press 'D' to delete a book from the Library",
       "Press 'S' to search the Library"
       choice = gets.chomp.downcase
  case choice
  when 'b'
    add_book
  when 'd'
    delete_book
  when 's'
    search
  end
end

def add_book
  puts "Enter the book's Title"
  title = gets.chomp
  puts "Enter the book's Author"
  author = gets.chomp
  puts "Enter the number of copies"
  copies = gets.chomp.to_i

  new_book = Book.new({'title' => title})
  new_book.save(copies)

  author_id = ''
  Author.all.each do |i|
    if i.name == author
      author_id = i.id
    end
  end
  if author_id == ''
    new_author = Author.new({'name' => author})
    new_author.save
    author_id = new_author.id
  end

  new_books_authors = Books_authors.new({'book_id' => new_book.id, 'author_id' => author_id})
  new_books_authors.save

  librarian_menu
end

def delete_book
  puts "Enter the title of the book you would like to delete"
  choice = gets.chomp
  Book.delete(choice)
  puts "Book Deleted!"
  librarian_menu
end

def search
  puts "Press 't' to search by title or 'a' to search by author."
  choice = gets.chomp
  case choice
  when 't'
    title_search
  when 'a'
    author_search
  end
end

def title_search
  puts "What is the title of the book?"
  choice = gets.chomp
  puts "Book found:"
  puts Book.search(choice)
  librarian_menu
end

def author_search
  puts "Who is the author of the book?"
  choice = gets.chomp
  puts "\nBook found:\n"
  puts Author.search(choice)[0].name
  puts "\n"
  librarian_menu
end


def patron_menu
  puts "Patron Portal",
       '-'*30,
       puts "Press 't' to search for a book by title"


      patron searched library  -->
        search for book by title or author
            return book with book count
              patron chooses 'check_out' -->
              enters title
              book count goes down by 1
            or
        get patron history





main
















# choose 1 for patron portal
# choose 2 for librarian portal


# patron portal menu
# ...
# ...
# ...


# librarian portal
# add a book
# search for a book
# edit a book
# get rid of a book
