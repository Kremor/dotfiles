#! /bin/fish

function run
    # Checks if a program is already running on the background.
    # If not executes it with the included parameters.
    set command $argv[1]
    set exists (which $command ^&1 | grep -E (echo 'no' $command))

    if test "$exists" = ""
        set pid (pidof $command)
        if test "$pid" = ""
            $argv & disown
        else
            echo $command is already running
        end
    else
        echo "unknow command:" $command
    end
end

run blueman-applet
run compton --config ~/.config/compton/compton.conf
run nm-applet
run pamac-tray
run pa-applet
run redshift
run syncthing-gtk  -m
run thunar --daemon
run xfce4-power-manager
run xfsettingsd
run urxvtd

# Remaps keyboard
numlockx on
setxkbmap

# Changes key configuration
xmodmap $HOME/.config/xmodmap/xmodmap.conf
