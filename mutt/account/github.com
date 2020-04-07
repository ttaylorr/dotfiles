set imap_user = 'ttaylorr@github.com'
set imap_pass = `security find-internet-password -g -a ttaylorr@github.com -s imap.gmail.com 2>&1 | perl -e 'if (<STDIN> =~ m/password: "(.*)"$/ ) { print $1; }'`

set folder = imaps://imap.gmail.com/
set spoolfile = +INBOX
set record = "+[Gmail]/Sent Mail"
set postponed = "+[Gmail]/Drafts"

set from = "ttaylorr@github.com"

set sendmail="/usr/local/bin/msmtp -a github.com"

set header_cache="~/.mail/cache/github.com/header"
set message_cachedir="~/.mail/cache/github.com/message"

send2-hook '~C git@vger.kernel.org' 'set sendmail="/usr/local/bin/msmtp -a ttaylorr.com"'
send2-hook '~C git@vger.kernel.org' 'my_hdr From: Taylor Blau <me@ttaylorr.com>'
