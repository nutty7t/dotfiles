if $KEYBOARD_LAYOUT == 'colemak'

	" Based on the evil-colemak-basics remapping, adapted for Colemak Mod DHm
	" https://github.com/wbolster/evil-colemak-basics

	" hjkl
	noremap m h
	noremap n j
	noremap e k
	noremap i l

	" marks
	noremap h m

	" next/previous
	noremap k n
	noremap K N

	" insert
	noremap u i
	noremap U I

	" undo
	noremap l u

	" join lines
	noremap N J

	" lookup
	noremap E K

	" jump to end of word
	noremap j e
	noremap J E

elseif $KEYBOARD_LAYOUT == 'qwerty'

	" escape from the home row
	inoremap fd <ESC>
	vnoremap fd <ESC>

endif
