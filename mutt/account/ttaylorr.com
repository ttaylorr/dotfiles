mailboxes +ttaylorr.com/INBOX

set from = "me@ttaylorr.com"
set mbox = "+ttaylorr.com/archive"
set postponed = "+ttaylorr.com/drafts"
set spoolfile = "+ttaylorr.com/INBOX"

set sendmail="/usr/local/bin/msmtp -a ttaylorr.com"

set header_cache="~/.mail/cache/ttaylorr.com/header"
set message_cachedir="~/.mail/cache/ttaylorr.com/message"

macro index ga "<change-folder>=ttaylorr.com/archive<enter>" "Go to all mail"
macro index gd "<change-folder>=ttaylorr.com/drafts<enter>" "Go to drafts"
macro index gi "<change-folder>=ttaylorr.com/INBOX<enter>" "Go to inbox"
macro index gs "<change-folder>=ttaylorr.com/[Gmail].Starred<enter>" "Go to starred"
macro index gt "<change-folder>=ttaylorr.com/trash<enter>" "Go to trash"
macro index,pager e "<save-message>=ttaylorr.com/archive<enter>" "Archive"
macro index,pager d "<save-message>=ttaylorr.com/trash<enter>" "Trash"

bind index O "<shell-escape>offlineimap -qa ttaylorr<enter>"
