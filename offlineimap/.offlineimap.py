#!/usr/bin/env python
import re, subprocess

def forward_nametrans(folder):
    return {'archive':   '[Gmail]/All Mail',
            'important': '[Gmail]/Important',
            'sent':      '[Gmail]/Sent Mail',
            'spam':      '[Gmail]/Spam',
            'starred':   '[Gmail]/Starred',
            'trash':     '[Gmail]/Trash',
            'drafts':    '[Gmail]/Drafts',
           }.get(folder, folder)

def reverse_nametrans(folder):
    return {'[Gmail]/All Mail':  'archive',
            '[Gmail]/Drafts':    'drafts',
            '[Gmail]/Important': 'important',
            '[Gmail]/Sent Mail': 'sent',
            '[Gmail]/Spam':      'spam',
            '[Gmail]/Starred':   'starred',
            '[Gmail]/Trash':     'trash',
           }.get(folder, folder)


def get_keychain_pass(account=None, server=None):
    params = {
        'security': '/usr/bin/security',
        'command': 'find-internet-password',
        'account': account,
        'server': server,
        'keychain': '/Users/ttaylorr/Library/Keychains/login.keychain',
    }

    cmd = "%(security)s -v %(command)s -g -a %(account)s -s %(server)s %(keychain)s" % params
    out = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)

    txt = [l for l in out.splitlines() if l.startswith('password: ')][0]

    return re.match(r'password: "(.*)"', txt).group(1)
