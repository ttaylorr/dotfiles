set imap_user = 'ttaylorr@github.com'
set imap_pass = `security find-internet-password -w -a ttaylorr@github.com -s imap.gmail.com`

set folder = imaps://imap.gmail.com/
set spoolfile = +INBOX
set record = "+[Gmail]/Sent Mail"
set postponed = "+[Gmail]/Drafts"

set from = "ttaylorr@github.com"

set sendmail="/usr/local/bin/msmtp -a github.com"

set index_format="%4C %Z %{%b %d} %-15.15L %?y?[%y]? %s"

set message_cachedir="~/.mail/cache/github.com/message"

send2-hook '~C git@vger.kernel.org' 'set sendmail="/usr/local/bin/msmtp -a ttaylorr.com"'
send2-hook '~C git@vger.kernel.org' 'my_hdr From: Taylor Blau <me@ttaylorr.com>'
