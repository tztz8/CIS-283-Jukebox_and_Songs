# CIS-283-Jukebox_and_Songs
 For SCC CIS 283 class

doc -> md

**Jukebox**

Write a program that implements a Song class which can store specific information about a particular song.
    Write the appropriate getter/setter methods (attr\_accessor) to set the following information for each Song object
       Title, Artist, Album, Year, Comments, Length in seconds

Write some class methods that let you print a song&#39;s details and &quot;play&quot; a song (basically just print out a string that says the song is playing&quot;.

Write another class called Jukebox which handles storing multiple songs into an array that is INSIDE the Jukebox class. An object created from this class should respond to adding, deleting, updating, and listing all of the Song objects stored inside of it.

  The main program should implement a menu that allows a user to create a new song and fill in the appropriate information. They should also be able to add, update, delete, print/play a song, and exit.   Write a method for converting the object into a tab delimited string suitable for writing/saving.
   Store the information for each new song in a new Song object. Then add that song to the Jukebox object through the method &quot;add\_song&quot;.

When the user quits, save the all the song objects from your Jukebox object into a simple tab delimited file – THE SAME ONE FROM WHICH YOU READ THE SONGS.
      Read a tab delimited file to populate your songs structure with Song objects and then put those songs into the Jukebox.

Your classes should NOT do any printing themselves, but allow the main program which uses them to display the status/strings from your class.

Your Main program should have AT LEAST the following menu options:

1. Show all songs that are longer than a user entered value (in seconds)
2. Show All songs that were written by a specific author (user entered name)
3. Play a specific song
4. Add a new song to the jukebox from user input
5. Delete a song from the jukebox
6. Update a song in the jukebox
7. Show all songs in the jukebox

You should submit 4 files with this assignment:

Songs.rb (Song class)

Jukebox.rb (Jukebox Class)

Main.rb (Main program which includes Songs and Jukebox)

Songs.txt (Text file of your songs to store permanently)
