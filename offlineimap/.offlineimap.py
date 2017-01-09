#!/usr/bin/env python
import re, subprocess

def get_keychain_pass(account=None, server=None):
    params = {
        'security': '/usr/bin/security',
        'command': 'find-internet-password',
        'account': account,
        'server': server,
        'keychain': '/Users/ttaylorr/Library/Keychains/login.keychain',
    }

    cmd = "sudo %(security)s -v %(command)s -g -a %(account)s -s %(server)s %(keychain)s" % params
    out = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)

    txt = [l for l in out.splitlines() if l.startswith('password: ')][0]

    return re.match(r'password: "(.*)"', txt).group(1)
