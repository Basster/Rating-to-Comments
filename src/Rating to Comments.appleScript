(*
"Copy Rating to Comment" for iTunes
written by Ole Rößner
oroessner@gmail.com
July 8, 2010
*)

tell application "System Events"
if (get name of every process) contains "iTunes" then set okflag to true
end tell
if okflag then -- iTunes is running, let's go
  tell application "iTunes.app"
    set thePlaylist to the front window's «class pPly»

    -- which tracks to use?
    if selection is {} then
      set allTracks to every «class cTrk» of thePlaylist
    else
      set allTracks to a reference to selection
    end if

    repeat with this_track in allTracks
      set this_comment to this_track's «class pCmt»
      set this_rating to this_track's «class pRte»
      set this_rating to this_rating / 20

      set firstChar to ""

      if this_rating > 0 then

        set new_comment to ""

        repeat this_rating times
          set new_comment to new_comment & "*"
        end repeat

        if this_comment's length > 0 and this_comment contains "*" then

          set this_comment to my replaceText(" | ", "", this_comment)
          set this_comment to my replaceText("*", "", this_comment)

        end if

        if this_comment's length > 0 then
          set new_comment to new_comment & " | " & this_comment
        end if

        --display dialog new_comment
        set this_track's «class pCmt» to new_comment
      end if

    end repeat
  end tell
end if

on replaceText(find, replace, subject)
  set prevTIDs to text item delimiters of AppleScript
  set text item delimiters of AppleScript to find
  set subject to text items of subject

  set text item delimiters of AppleScript to replace
  set subject to "" & subject
  set text item delimiters of AppleScript to prevTIDs

  return subject
end replaceText
