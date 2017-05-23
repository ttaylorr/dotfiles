mailboxes +github.com/INBOX

set from = "ttaylorr@github.com"
set mbox = "+github.com/archive"
set postponed = "+github.com/drafts"
set spoolfile = "+github.com/INBOX"

set sendmail="/usr/local/bin/msmtp -a github.com"

macro index ga "<change-folder>=github.com/archive<enter>" "Go to all mail"
macro index gd "<change-folder>=github.com/drafts<enter>" "Go to drafts"
macro index gi "<change-folder>=github.com/INBOX<enter>" "Go to inbox"
macro index gs "<change-folder>=github.com/[Gmail].Starred<enter>" "Go to starred"
macro index gt "<change-folder>=github.com/trash<enter>" "Go to trash"
macro index,pager e "<save-message>=github.com/archive<enter>" "Archive"
macro index,pager d "<save-message>=github.com/trash<enter>" "Trash"
