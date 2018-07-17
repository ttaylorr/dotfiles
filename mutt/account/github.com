mailboxes +github.com/INBOX \
          +github.com/@git-core \
          +github.com/@git-ecosystem \
          +github.com/@git-infrastructure \
          +github.com/@me \
          +github.com/git-lfs \
          +github.com/git.git \
          +github.com/archive \
          +github.com/drafts \
          +github.com/sent \
          +github.com/spam \
          +github.com/starred \
          +github.com/trash \

set from = "ttaylorr@github.com"
set mbox = "+github.com/archive"
set postponed = "+github.com/drafts"
set spoolfile = "+github.com/INBOX"

set sendmail="/usr/local/bin/msmtp -a github.com"

set header_cache="~/.mail/cache/github.com/header"
set message_cachedir="~/.mail/cache/github.com/message"

macro index ga "<change-folder>=github.com/archive<enter>" "Go to all mail"
macro index gd "<change-folder>=github.com/drafts<enter>" "Go to drafts"
macro index gi "<change-folder>=github.com/INBOX<enter>" "Go to inbox"
macro index gs "<change-folder>=github.com/[Gmail].Starred<enter>" "Go to starred"
macro index gt "<change-folder>=github.com/trash<enter>" "Go to trash"
macro index,pager e "<save-message>=github.com/archive<enter>" "Archive"
macro index,pager d "<save-message>=github.com/trash<enter>" "Trash"

send2-hook '~C git@vger.kernel.org' 'set sendmail="/usr/local/bin/msmtp -a ttaylorr.com"'
send2-hook '~C git@vger.kernel.org' 'my_hdr From: Taylor Blau <me@ttaylorr.com>'
