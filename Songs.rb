############################################################
#
#  Name:        Timbre Freeman
#  Assignment:  Jukebox
#  Date:        02/19/2020
#  Class:       CIS 283
#  Description: Jukebox and Songs - Song-Class
#
############################################################

class Song
  # Title, Artist, Album, Year, Comments, Length in seconds
  attr_accessor :album, :title, :year, :artist, :comments, :length

  def self.ask_user_for_song
    # Title, Artist, Album, Year, Comments, Length in seconds
    print "Title: "
    title = gets.chomp
    puts ""
    print "Author Name: "
    author_name = gets.chomp
    puts ""
    print "Album: "
    album = gets.chomp
    puts ""
    print "Year: "
    year = gets.chomp.to_i
    puts ""
    print "Comments: "
    comments = gets.chomp
    puts ""
    print "length in seconds: "
    length = gets.chomp.to_i
    puts ""
    return Song.new(title,author_name,album,year,length,comments)
  end

  def self.blank
    return Song.new("BLANK", "NA", "NA", 0000, 0, "NA")
  end

  def initialize(title, artist, album, year, length_in_seconds, comments = "")
    @title = title
    @artist = artist
    @album = album
    @year = year
    @comments = comments
    @length = length_in_seconds
  end

  def related_to(song)
    original_song = self.to_s
    if (original_song =~ /^#{song.title}\s+([a-zA-z ']+)\s+([a-zA-z ']+)\s+(\d{4})\s([a-zA-z ']*)\s+(\d+)$/)
      return true
    elsif (original_song =~ /^([a-zA-z ']+)\s+#{song.artist}\s+([a-zA-z ']+)\s+(\d{4})\s([a-zA-z ']*)\s+(\d+)$/)
      return true
    elsif (original_song =~ /^([a-zA-z ']+)\s+([a-zA-z ']+)\s+#{song.album}\s+(\d{4})\s([a-zA-z ']*)\s+(\d+)$/)
      return true
    elsif (original_song =~ /^([a-zA-z ']+)\s+([a-zA-z ']+)\s+([a-zA-z ']+)\s+#{song.year}\s([a-zA-z ']*)\s+(\d+)$/)
      return true
    elsif (original_song =~ /^([a-zA-z ']+)\s+([a-zA-z ']+)\s+([a-zA-z ']+)\s+(\d{4})\s#{song.comments}\s+(\d+)$/)
      return true
    elsif (original_song =~ /^([a-zA-z ']+)\s+([a-zA-z ']+)\s+([a-zA-z ']+)\s+(\d{4})\s([a-zA-z ']*)\s+#{song.length}$/)
      return true
    else
      return false
    end
  end

  def print(song = self)
    puts "Title: #{song.title}, Artist: #{song.artist}, Album: #{song.album}, Year: #{song.year}, Length: #{song.length}sec, Comments: #{song.comments}"
  end

  def to_s
    return "#{@title}\t#{@artist}\t#{@album}\t#{@year}\t#{@comments}\t#{@length}"
  end
end