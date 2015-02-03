#!/usr/bin/python
# -*- coding: utf-8 -*-
# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = '''
---
module: unzip
version_added: "1.8"
short_description: Unzips files on windows machines
description:
     - Unzips files on windows machines
options:
  destination:
    description:
      - Destination for unzipped files
    required: true
    default: null
    aliases: []
  source:
    description:
      - Source of zip file
    required: true
    default: null
    aliases: []
author: Michael Perzel / Justin Rocco
'''

EXAMPLES = '''
# This unzips a file
$ ansible -i hosts -m unzip -a "source=file.zip destination=c:\" all


# Playbook example
---
- name: Unzip file
  hosts: all
  gather_facts: false
  tasks:
    - name: Unzip file
      unzip: source="C:\File.zip" destination="C:\"

'''