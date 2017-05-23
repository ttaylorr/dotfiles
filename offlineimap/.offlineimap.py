#!/usr/bin/env python
import re, subprocess

def forward_nametrans(folder):
    return {'drafts':  '[Gmail]/Drafts',
            'sent':    '[Gmail]/Sent',
            'trash':   '[Gmail]/Trash',
            'archive': '[Gmail]/All Mail',
           }.get(folder, folder)

def reverse_nametrans(folder):
    return {'[Gmail]/Drafts':   'drafts',
            '[Gmail]/Sent':     'sent',
            '[Gmail]/Trash':    'trash',
            '[Gmail]/All Mail': 'archive',
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
