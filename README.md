# Customizing a newly installed Ubuntu 16.04 system

## Install Windows alongside Ubuntu
* The Windows installation will override the grub loader.
* Fixing the grub loader is easy. See [here](https://superuser.com/questions/1205926/installing-windows-10-alongside-ubuntu-16-04-and-adding-to-grub).
  P.S. This method didn't quite work for me when I type update-grub or
  grub-install in the live Ubuntu USB.
* At the end, I solve the problem boot loader problem using
  `boot-repair`, see [here](https://help.ubuntu.com/community/RecoveringUbuntuAfterInstallingWindows).

## Configure system wide shorcuts
```
sudo apt-get install compizconfig-settings-manager
sudo apt-get install compiz-plugins
```

### [Disable sceen locking when hitting `Super+L`](https://stackoverflow.com/questions/24908490/ubuntu-do-not-lock-the-screen-when-pressing-superl)
* Press super key -> Search "CompizConfig Settings Manager" -> Ubuntu Unity Plugin -> Disable "Key to lock the screen".

### Use `Super+D` to show desktop
* Press super key -> Search "CompizConfig Settings Manager" -> General Options -> Key bindings -> Set "Show Desktop" to `Super+D`.

### Use `Super+K` to maximize window
* Press super key -> Search "CompizConfig Settings Manager" -> General Options -> Key bindings -> Set "Maximize Window" to `Super+K`.

### Use `Super+H`, `Super+L` and `Super+K` to dock and maximize window
* Press super key -> Search "CompizConfig Settings Manager" -> Window Mangement -> Grid -> Set "Left Maximize" to `Super+H`.
* Press super key -> Search "CompizConfig Settings Manager" -> Window Mangement -> Grid -> Set "Right Maximize" to `Super+L`.

### Use `Super+Y` and `Super+O` to move window to other monitors
* Press super key -> Search "CompizConfig Settings Manager" -> Window Mangement -> Put -> Set "Put To Next Output" to `Super+O`.
* Press super key -> Search "CompizConfig Settings Manager" -> Window Mangement -> Put -> Set "Put To Previous Output" to `Super+Y`.

### Use `Ctrl+J` and `Ctrl+K` to switch tabs in *Nautilus*
* Paste the following to the end of *~/.config/nautilus/accels*
    ```
    (gtk_accel_path "<Actions>/ShellActions/TabsPrevious" "<Primary>j")
    (gtk_accel_path "<Actions>/ShellActions/TabsNext" "<Primary>k")
    ```
  [Don't forget to remove the `;` symbol in front of the line.](https://askubuntu.com/questions/287936/changing-nautilus-key)


### Use `ctrl+alt+A` to take a screenshot
#### Method 1: Use the built-in screenshot function
* Press super key -> Search "keyboard" -> Shortcuts -> Screenshots -> Set "Take a screenshot of an area" to `ctrl+alt+A`.
#### Method 2: Use Flameshot
* Download Flameshot: https://flameshot.js.org/#/getting-start
* Search and open Flameshot by pressing the super key, or by typing `flameshot` in cmd.
* Click the Flameshot icon at top-left corner -> Configuration -> General -> Check Launch at startup.
* Press super key -> Search "keyboard" -> Shortcuts -> Custom Shortcuts -> Click the "+" button -> Assign shortcut `Ctrl+Alt+A` to command `flameshot gui`.
* Press `Ctrl+Alt+A` to select region. Press `Ctrl+C` to copy to clipboard, or Press `Ctrl+S` to save to file.

## Fix Trackpoint Scrolling Issue
[Simply intall](https://gist.github.com/tsrivishnu/5b467f07374ce42ad6d97b6a3fdf0ea5):
```
sudo apt-get install xserver-xorg-input-libinput
```

## Disable Touchpad
* Press super key -> System Settings -> Mouse & Touchpad -> Touchpad -> Set "Enable" to OFF.

* It appears that after installing libinput, [the touchpad option disappears](https://askubuntu.com/questions/783396/mouse-touchpad-separate-settings-missing)
  in "System Settings -> Mouse & Touchpad". To [disable the touch pad again](https://askubuntu.com/questions/65951/how-to-disable-the-touchpad),
  type
  ```
  xinput list
  xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0
  ```
  However, using this approach you need to retype the above command every
  time you reboot your system. To permanently disable touchpad, 
  [use touchpad indicator](https://itsfoss.com/disable-touchpad-when-mouse-used/):
  ```
  sudo add-apt-repository ppa:atareao/atareao
  sudo apt update
  sudo apt install touchpad-indicator
  ```
  - Press Super Key -> Touchpad Indicator -> Actions -> On Touchpad indicator starts -> Check "Disable touchpad".
  - Press Super Key -> Touchpad Indicator -> Actions -> On Touchpad indicator ends -> Check "Disable touchpad".
  - Press Super Key -> Touchpad Indicator -> Actions -> General Options -> Set "Autostart" on.

  To get a deeper understanding on libinput, read [this](https://wiki.archlinux.org/index.php/Libinput).

## Configure shadowsocks
* [Install `shadowsocks-libev` from PPA](https://github.com/shadowsocks/shadowsocks-libev): 
    ```
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository ppa:max-c-lv/shadowsocks-libev -y
    sudo apt-get update
    sudo apt install shadowsocks-libev
    ```
* Setup shadowsocks to run on startup
    ```
    sudo echo "#!/bin/sh" >> /etc/init.d/mystartup.sh
    sudo echo "ss-local -c /home/chizhang/etc/shadowsocks/digital-ocean-singapore.json -u -v" >> /etc/init.d/mystartup.sh
    sudo chmod +x /etc/init.d/mystartup.sh
    sudo update-rc.d mystartup.sh defaults
    ```
* Setup proxy in ProxySwitchOmega: 
    * Select or create a profile, name it "shadowsocks", set server parameters as following
        - Protocol: SOCKS5
        - Server: 127.0.0.1
        - Port: 1080
    * Select the "auto switch" profile:
        - Add a rule list, and set rule list URL To `https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt`
        - Ues the "shadowsocks" profile for the rule list rules.
        - Use "Direct" for default situation.

## Configue vim/gvim
### Install vimplug
* Run
    ```
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
* Open vim or gvim and type `:PlugInstall` to install plugins specified in `.vimrc`.

### Install the Molokai color scheme
* Run
    ```
    mkdir -p ~/.vim/colors/
    wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim ~/.vim/colors/
    ```

## Install Chinese input method
1. Install fcitx and Google Pinyin [link](http://ubuntuhandbook.org/index.php/2016/07/2-best-chinese-pinyin-im-ubuntu-16-04/)
    ```
    sudo apt-get install fcitx fcitx-googlepinyin
    ```
2. Press Super Key -> Language Support -> Set "Keyboard input method system" to *fcitx*.
3. Reboot and you will see a keyboard icon on the top right corner of the desktop.
4. Click the keyboard icon -> ConfigureFcitx -> Click the '+' icon at the lower left -> Select "Google Pinyin" -> OK.
5. Now you can use `ctrl+space` to switch input methods.

## Make dates in `ls` shown in English instead of Chinese
* Press Super Key -> Language Support -> Regional Formats -> Choose "English (United States)" -> Apply System-Wide -> Re-login for change to take effect.

## Change apt source to aliyun.com
* Run
    ```
    sudo apt-get install software-center
    ```
* Open ""Ubuntu Software Center" (Not "Ubuntu Software) -> Menu -> Edit -> Software Sources -> Edit "Download from...".

## Install Consolas font
* [Click here to original post.](https://www.rushis.com/consolas-font-on-ubuntu/)

## Configure PDF Reader.
* `sudo apt-get install okular`.
* Okular -> Settings -> Configure Okular -> General -> Check "Open new files in tabs".
* Okular -> Settings -> Configure Okular -> Accessibility -> Set "Page color" to RGB(199, 237, 204).
* Okular -> Settings -> Configure Shortcuts -> Add alternate shortcut 'Y' to action "Beginning of the document".
* Okular -> Settings -> Configure Shortcuts -> Add alternate shortcut 'O' to action "End of the document".
* Okular -> Settings -> Configure Shortcuts -> Add alternate shortcut 'U' to action "Scroll Page Up".
* Okular -> Settings -> Configure Shortcuts -> Add alternate shortcut 'I' to action "Scroll Page Down".
* Use `ctrl+,` and `ctrl+.` to navigate between tabs.
* Use `ctrl+4` to activate regular text selection, instead of selecting text by a rectangle.

## Fix dbus Issue When Openning gvim from tmux
* If gvim tells you it cannot load or save configuration files (see
  problem phenomenon [here](https://vi.stackexchange.com/questions/6222/how-to-resolve-gvim-startup-error-no-d-bus-daemon-running))
  when it is started from a tmux terminal, and clicking the "detail"
  button shows "No D-BUS daemon running", the reason and solution can be
  found [here](https://askubuntu.com/questions/51132/gnome-open-raises-this-error-when-run-from-inside-tmux/263864):
  Create `~/.config/upstart/dbus.override` with the following content:
  ```
  pre-start script
      DBUS_SESSION_BUS_ADDRESS=unix:path=$HOME/.dbus-$(hostname)-$(echo $DISPLAY | sed -e s/:/%3A/)
      initctl set-env DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS
  end script
  ```
  Reboot, then you are all set.

## Fix issue that AceJump shortcut `ctrl+;` got hijacked
> [The problem is caused by an addon in fcitx named Clipboard. To disable it, simply open Fcitx Configuration -> Addon -> Clipboard, then either disable it or change its trigger key.](https://askubuntu.com/questions/894673/why-my-ctrlsemicolon-was-binded-globally)

## Let PyCharm autocomplete PyQt
* I've installed PyQt4 by `sudo apt-get install python3-pyqt4`.
* PyCharm cannot find my PyQt4 because the index has been built before I install PyQt.
* Solution: File -> Invalidate Cache / Restart.

## Let Clion inherit ROS shell environment automatically on startup
* Append the following line to `~/.bashrc`:
  `source /opt/ros/kinetic/setup.bash`.

* Edit the desktop file located at 
  `~/.local/share/applications/jetbrains-clion.desktop`.

* Modify the line containing Exec= to
  `Exec=bash -i -c "/INSTALL_LOCATION/clion-2016.3.2/bin/clion.sh" %f`.

## Install CloudCompare
* Run 
    ```
    snap find cloudcompare
    sudo snap install cloudcompare
    ```

## Install Meshlab
* Run
    ```
    sudo add-apt-repository ppa:zarquon42/meshlab
    sudo apt-get update
    sudo apt-get install meshlab
    ```
## Associate .ply .off .las files with MeshLab or CloudCompare
* How to make MeshLab/CloudCompare appear in Nautilus's context menu?
    * https://askubuntu.com/questions/145878/how-do-i-make-meshlab-the-default-viewer-for-stl-files
    * Open `.local/share/applications/meshlab.desktop`, change `Exec=meshlab` into `Exec=meshlab %f`. Save and exit. Now Meshlab should be listed in Nautilus's context menu.
    * Open `.local/share/applications/cloudcompare.desktop`, change `Exec=CloudCompare` into `Exec=cloudcompare.CloudCompare %f`. Save and exit. Now CloudCompare should be listed in Nautilus's context menu.
    * Note: There is no need to even restart Nautilus, let alone a total reboot.

* How to associate file *extension (not file type)* for a particular application?
    * https://askubuntu.com/questions/55653/how-to-associate-file-extension-not-file-type-for-a-particular-application

## Fix PyCharm's low resolution icon on launcher
* Open `~/.local/share/applications/jetbrains-pycharm.desktop`, Change
  the line `Icon=` to the correct path: e.g.
  `Icon=/home/chizhang/bin/pycharm-2018.2.4/bin/pycharm.png`.

## Disable gnome-binded `ctrl+alt+down` and `ctrl+alt+up`
* Motivation: CLion uses the same shortcuts to navigate between prev and
  next occurence of build error, but get intercepted the gnome default
  binding.
* [Removing the shortcuts using dconf-editor](https://unix.stackexchange.com/questions/394143/how-to-disable-gnome-ctrlaltdown-and-ctrlaltup-shortcut):
    * `sudo apt-get install dconf-tools`
    * `dconf-editor`
    * in dconf-editor go to: /org/gnome/desktop/wm/keybindings/
    * Find switch-to-workspace-down, put ['disabled'] instead of default
    * same for ...-up
    * quit dconf-editor and you are done

## Use a custom navigatable and colorful version of the `tree` command
* Put the custom `tree` file under `${THIS_PROJECT}/script` to `~/bin`.
* On Ubuntu 16.04 `~/bin` is automatically included in `$PATH` (see
  `~/.profile`), if not [add it manually.](https://askubuntu.com/a/60221)
