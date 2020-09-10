set imap_user = 'ttaylorr@github.com'
set imap_pass = `pass show imap.gmail.com/github`
set imap_keepalive = 300

set folder = imaps://imap.gmail.com/
set spoolfile = +INBOX
set record = "+[Gmail]/Sent Mail"
set postponed = "+[Gmail]/Drafts"

set from = "ttaylorr@github.com"

set header_cache="~/.mail/cache/github.com/header"

set sendmail="/usr/local/bin/msmtp -a github.com"

set index_format="%4C %Z %{%b %d} %-15.15L %?y?[%y]? %s"

set message_cachedir="~/.mail/cache/github.com/message"

macro index ga "<change-folder>=[Gmail]/All Mail<enter><enter>" "Go to all mail"
macro index gd "<change-folder>=[Gmail]/Drafts<enter>" "Go to drafts"
macro index gs "<change-folder>=[Gmail]/Starred<enter>" "Go to starred"
macro index gi "<change-folder>=INBOX<enter>" "Go to inbox"
macro index gs "<change-folder>=[Gmail]/Trash<enter>" "Go to trash"
macro index e "<tag-prefix><delete-message><Tab>" "Archive"
macro pager e "<delete-message>" "Archive"

macro index,pager < "<tag-prefix><copy-message>~/git-new.mbox<enter>" "mark new"

send2-hook '~C git@vger.kernel.org' 'set sendmail="/usr/local/bin/msmtp -a ttaylorr.com"'
send2-hook '~C git@vger.kernel.org' 'my_hdr From: Taylor Blau <me@ttaylorr.com>'
