set imap_user = 'me@ttaylorr.com'
set imap_pass = `pass show imap.gmail.com/ttaylorr 2>/dev/null`
set imap_keepalive = 300

set folder = imaps://imap.gmail.com/
set spoolfile = +INBOX
set record = "+[Gmail]/Sent Mail"
set copy = no
set postponed = "+[Gmail]/Drafts"

set from = "me@ttaylorr.com"

set sendmail="/usr/local/bin/msmtp -a ttaylorr.com"

set header_cache="~/.mail/cache/ttaylorr.com/header"
set message_cachedir="~/.mail/cache/ttaylorr.com/message"

macro index ga "<change-folder>=[Gmail]/All Mail<enter><enter>" "Go to all mail"
macro index gd "<change-folder>=[Gmail]/Drafts<enter>" "Go to drafts"
macro index gs "<change-folder>=[Gmail]/Starred<enter>" "Go to starred"
macro index gi "<change-folder>=INBOX<enter>" "Go to inbox"
macro index gs "<change-folder>=[Gmail]/Trash<enter>" "Go to trash"
macro index e "<tag-prefix><delete-message><Tab>" "Archive"
macro pager e "<delete-message>" "Archive"
