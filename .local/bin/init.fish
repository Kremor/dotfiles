#! /bin/fish

function run
    # Checks if a program is already running on the background.
    # If not executes it with the included parameters.
    set pid (pidof $argv[1])

    if test "$pid" = ""
        $argv &
    else
        echo $argv[1] is already running
    end
end

# compton
run compton --vsync opengl

# redshift
run redshift

# Network manager
run nm-applet

# Thunar
run thunar --daemon

# Pamac
run pamac-tray

# XFCE Settings Daemon
run xfsettingsd

numlockx on
feh --randomize --bg-tile $HOME/.background.png

# Changes key configuration
xmodmap $HOME/.config/xmodmap/xmodmap.conf
