(*
Insert Template 3.applescript
Sample Script for CotEditor

Description:
Wraps the selection of the frontmost window with two user-defined strings, then places the caret right after the inserted strings. If no selection is made, places the caret between the two strings.
You can also set the cursor location setting perMargin property.


最前面のウィンドウの選択範囲を設定されたふたつの文字列で囲み、キャレットを新しい文字列の直後に移動します。選択範囲がないときは、ふたつの文字列の間にキャレットを移動させます。
property preMargin に 0 以外の数値を入れると、処理前の選択範囲の開始位置から preMargin 文字分、キャレットを強制的に移動できます。

written by nakamuxu on 2005-04-14
modified by 1024jp on 2014-11-22
*)

property beginStr : "<h1>" -- string to insert before the selection
property endStr : "</h1>" -- string to insert after the selection
property preMargin : 0 -- number of characters to move cursor from the insertion point

--
tell application "CotEditor"
	if not (exists front document) then return
	
	tell front document
		set {loc, len} to range of selection
		if (len = 0) then -- if no text was selected
			set newStr to beginStr & endStr
			
			if (preMargin = 0) then
				set numOfMove to count of character of beginStr
			else
				set numOfMove to preMargin
			end if
			
		else if (len > 0) then
			set curStr to contents of selection
			set newStr to beginStr & curStr & endStr
			
			if (preMargin = 0) then
				set numOfMove to count of character of newStr
			else
				set numOfMove to preMargin
			end if
		else
			return
		end if
		
		-- replace selection with the new text
		set contents of selection to newStr
		
		-- move the cursor to the desired location
		set range of selection to {loc + numOfMove, 0}
	end tell
end tell
