#! /usr/bin/env bash

export PATH="$(_file_path $(echo $(which python3) | _readlink)):$PATH"
export PATH="$(python_site_user_base)/bin:$PATH"
