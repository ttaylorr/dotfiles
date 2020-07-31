set imap_user = 'me@ttaylorr.com'
set imap_pass = `security find-internet-password -w -a me@ttaylorr.com -s imap.gmail.com`
set imap_keepalive = 300

set folder = imaps://imap.gmail.com/
set spoolfile = +INBOX
set record = "+[Gmail]/Sent Mail"
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
macro index e "<tag-prefix><save-message>=[Gmail]/All Mail<enter>" "Archive"
macro index d "<tag-prefix><save-message>=[Gmail]/Trash<enter>" "Trash"
macro pager e "<save-message>=[Gmail]/All Mail<enter>" "Archive"
macro pager d "<save-message>=[Gmail]/Trash<enter>" "Trash"
