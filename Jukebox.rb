############################################################
#
#  Name:        Timbre Freeman
#  Assignment:  Jukebox
#  Date:        02/19/2020
#  Class:       CIS 283
#  Description: Jukebox and Songs - Jukebox-Class
#
############################################################
require '.\Songs.rb'

class Jukebox
  attr_reader :songs, :song_file_name, :song_playing, :song_is_playing_flag

  def self.print_songs(songs)
    songs.each do |song|
      song.print
    end
  end

  def initialize(song_file_name = "songs.txt")
    @song_file_name = song_file_name
    @songs = []
    load_songs
    @song_playing = Song.blank
    @time_start = 0
    @song_is_playing_flag = false
  end

  def songs_longer_than(seconds)
    return_songs = []
    @songs.each do |song|
      if (song.length > seconds)
        return_songs.push(song)
      end
    end
    return return_songs
  end

  def songs_made_by(author_name)
    return_songs = []
    @songs.each do |song|
      if song.artist =~ /#{author_name}/
        return_songs.push(song)
      end
    end
    return return_songs
  end

  def save_songs(song_file_name = @song_file_name)
    @song_file = File.open(song_file_name, "w+")
    @songs.each do |song|
      @song_file.puts song.to_s
    end
    @song_file.close
  end

  def add_song(song)
    @songs.push(song)
    self.save_songs
  end

  def find_songs(song_in)
    songs = []
    @songs.each do |song|
      if (song.related_to(song_in))
        songs.push(song)
      end
    end
    return songs
  end

  def remove_song(song)
    @songs.delete(song)
    self.save_songs
  end

  def play_song(song, print_message = false)
    @song_playing = song
    @song_is_playing_flag = true
    @time_start = Time.now.to_i
    if (print_message)
      puts "#{song.title} is playing"
    end
  end
  def play_song_using_int(song_int, print_message = false)
    self.play_song(songs[song_int], print_message)
  end

  def stop_playing
    @song_playing = Song.blank
    @song_is_playing_flag = false
    @time_start = 0
  end

  def time_left
    if (@time_start == 0)
      return @song_playing.length
    else
      time_now = Time.now.to_i
      if (time_now - @time_start) >= @song_playing.length
        return 0
      elsif (time_now - @time_start) < @song_playing.length
        return (@song_playing.length - (time_now - @time_start))
      end
    end
  end

  def just_end
    if (self.time_left == 0)
      if (@song_is_playing_flag)
        self.stop_playing
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def update_song(old_song, new_song)
    self.remove_song(old_song)
    self.add_song(new_song)
  end

  private
  def load_songs
    check_songs_file
    @song_file = File.open(song_file_name, "r")
    songs_data = @song_file.read.scan(/^([a-zA-z ']+)\s+([a-zA-z ']+)\s+([a-zA-z ']+)\s+(\d{4})\s([a-zA-z ']*)\s+(\d+)$/)
    puts songs_data.inspect if $debug
    songs_data.each do |song_data|
      @songs.push(Song.new(song_data[0], song_data[1], song_data[2], song_data[3].to_i, song_data[5].to_i, song_data[4]))
    end
    @song_file.close
  end

  def check_songs_file(song_file_name = @song_file_name)
    if !(File.exists?(song_file_name))
      puts "#{song_file_name} dose not exists -- making file now"
      @song_file = File.open(song_file_name, "w+")
      @song_file.close
    end
  end
end