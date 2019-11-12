---
# a. install osquery for windows hosts
- hosts: windows
  tasks:
    - name: Install Chocolatey package manager
      win_command: powershell.exe -
      args:
        stdin: Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) && SET "PATH=%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin"

    - name: Install osquery
      win_chocolatey:
        name: osquery_win
        state: present
    # a.1 Ensure that osquery has access to Windows even
    - name: Enable Windows Event Log for osquery
      win_command: powershell.exe -
      args:
        stdin: Set-ExecutionPolicy Bypadd -Scope Process -Force; C:\\ProgramData\\osquery\\manage-osqueryd.ps1 -installWelManifest

    - debug:
        var: task_result.stdout_lines

# b. install osquery for linux hosts
- hosts: linux
  tasks:
    - name: Add osquery key to apt
      apt_key:
        keyserver: keyserver.ubuntu.com
        id: 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
        state: present

    - name: Add osquery apt repo
      apt_repository:
        repo: deb [arch=amd64] https://pkg.osquery.io/deb deb main
        state: present

    - name: Update apt
      apt:
        update_cache: yes
        state: present

    - name: Install OSquery_nix
      apt:
        name: osquery
        state: present

    - debug:
        var: task_result.stdout_lines