#! /bin/fish

set compton (pidof compton)

if not test "$compton" = ""
    echo $compton
else
    compton --vsync opengl & disown
    echo "compton started"
end

set redshift (pidof redshift)
if not test "$redshift" = ""
    echo $redshift
else
    redshift & disown
    echo "redshift started"
end

numlockx on
feh --randomize --bg-tile $HOME/Downloads/blue.png
