############################################################
#
#  Name:        Timbre Freeman
#  Assignment:  Jukebox
#  Date:        02/17/2020
#  Class:       CIS 283
#  Description: Jukebox and Songs - using classes
#
############################################################
require '.\Jukebox.rb'

$debug = false

# menu
def menu(items = Array.new(2){"continue"})
  input_works = false
  while !input_works
    for i in 0...items.length
      puts "#{i+1})  #{items[i]}"
    end
    print "Enter option(1-#{items.length}): "
    user_input = gets.chomp.to_i
    puts ""
    if (user_input > 0) && (user_input <= items.length)
      input_works = true
      return user_input
    else
      puts "Error: must pick a option"
    end
  end
  return user_input
end

def menu_find_song(doing_string, jukebox_in)
  puts "Enter some song data. So we can find the song. (tip if you do not know press enter)"
  songs = jukebox_in.find_songs(Song.ask_user_for_song)
  songs.each do |song|
    puts song.print
    print "is this the song you want to #{doing_string}? (Y|N): "
    user_option = gets.chomp
    puts ""
    if (user_option =~ /^(y|Y)/)
      return song
    end
  end
  return Song.blank
end

jukebox = Jukebox.new()

$run_program = true

jukebox_playing_thr = Thread.new {
  while $run_program
    if jukebox.just_end
      puts ""
      puts "##############"
      puts "#Song is over#"
      puts "##############"
    end
    sleep(1)
  end
}

while $run_program
  puts "#-----------#"
  puts "|  Jukebox  |"
  puts "#-----------#"
  user_option = menu(["Show all songs that are longer than so many seconds",
                      "Show All songs that were written by a specific author",
                      "Play a specific song",
                      "Add a new song to the jukebox",
                      "Delete a song from the jukebox",
                      "Update a song in the jukebox",
                      "Show all songs in the jukebox",
                      "Exit"])

  # Show all songs that are longer than a user entered value (in seconds)
  if user_option == 1
    print "length in seconds: "
    length = gets.chomp.to_i
    puts ""
    puts "Songs longer than #{length}sec"
    Jukebox.print_songs(jukebox.songs_longer_than(length))

    # 2)	Show All songs that were written by a specific author (user entered name)
  elsif user_option == 2
    print "Author Name: "
    author_name = gets.chomp
    puts ""
    puts "Songs made by #{author_name}"
    Jukebox.print_songs(jukebox.songs_made_by(author_name))

    # 3)	Play a specific song
  elsif user_option == 3
    user_song = menu_find_song("play", jukebox)
    if (user_option != Song.blank)
      jukebox.play_song(user_song, true)
    else
      puts "No song is selected"
    end

    # 4)	Add a new song to the jukebox from user input
  elsif user_option == 4
    jukebox.add_song(Song.ask_user_for_song)

    # 5)	Delete a song from the jukebox
  elsif user_option == 5
    user_song = menu_find_song("remove", jukebox)
    if (user_option != Song.blank)
      jukebox.remove_song(user_song)
    else
      puts "Not Removed"
    end

    # 6)	Update a song in the jukebox
  elsif user_option == 6
    user_song = menu_find_song( "update", jukebox)
    if (user_song != Song.blank)
      puts "Original song"
      puts user_song.print
      jukebox.update_song(user_song, Song.ask_user_for_song)
    else
      puts "Not updated"
    end

    # 7)	Show all songs in the jukebox
  elsif user_option == 7
    puts "All Songs"
    Jukebox.print_songs(jukebox.songs)

    # 8) Exit
  elsif user_option == 8
    $run_program = false
    jukebox.save_songs
    jukebox_playing_thr.exit
    break
  end
  puts ""
end