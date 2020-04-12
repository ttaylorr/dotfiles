set imap_user = 'me@ttaylorr.com'
set imap_pass = `security find-internet-password -w -a me@ttaylorr.com -s imap.gmail.com`

set folder = imaps://imap.gmail.com/
set spoolfile = +INBOX
set record = "+[Gmail]/Sent Mail"
set postponed = "+[Gmail]/Drafts"

set from = "me@ttaylorr.com"

set sendmail="/usr/local/bin/msmtp -a ttaylorr.com"

set header_cache="~/.mail/cache/ttaylorr.com/header"
set message_cachedir="~/.mail/cache/ttaylorr.com/message"
