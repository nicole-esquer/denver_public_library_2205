require './lib/book'
require './lib/author'
require './lib/library'

RSpec.describe Library do
  before :each do
    @dpl = Library.new("Denver Public Library")
  end

  it "exists" do
    expect(@dpl).to be_a(Library)
  end

  it "has a name" do
    expect(@dpl.name).to eq("Denver Public Library")
  end

  it "starts with an empty array of books and authors" do
    expect(@dpl.books).to eq([])
    expect(@dpl.authors).to eq([])
  end

  it "can add authors and books" do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @dpl.add_author(charlotte_bronte)
    expect(@dpl.authors).to eq([charlotte_bronte])

    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    @dpl.add_books(jane_eyre)
    @dpl.add_books(professor)
    @dpl.add_books(villette)
    expect(@dpl.books).to eq([jane_eyre, professor, villette])

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @dpl.add_author(harper_lee)
    expect(@dpl.authors).to eq([charlotte_bronte, harper_lee])

    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    @dpl.add_books(mockingbird)
    expect(@dpl.books).to eq([jane_eyre, professor, villette, mockingbird])
  end

  xit "has a publication_year" do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @dpl.add_author(charlotte_bronte)
    @dpl.add_author(harper_lee)
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    @dpl.add_books(jane_eyre)
    @dpl.add_books(professor)
    @dpl.add_books(villette)
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    @dpl.add_books(mockingbird)

    expect(@dpl.publication_time_frame_for(charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})
    expect(@dpl.publication_time_frame_for(harper_lee)).to eq({:start=>"1960", :end=>"1960"})
  end
end
