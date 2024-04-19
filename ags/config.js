// compile, reset, apply
Utils.exec(`sassc ${App.configDir}/style/main.scss /tmp/ags.css`);

// custom icons
App.addIcons(`${App.configDir}/assets`);

import { Sep } from './lib/sep.js';
import { Battery_Bar, Battery_Circle } from './lib/battery.js';
import { Clock } from './lib/date.js';
import { Player } from './lib/player.js';
import { VolumeSlider, BacklightSlider, volume_reveal, brightness_reveal } from './lib/sliders.js';

// layout of the bar
function Left() {
    return Widget.Box({
        class_name: 'left',
        hpack: 'start',
        spacing: 8,
        children: [Battery_Circle(), Battery_Bar()],
    });
}

function Center() {
    return Widget.Box({
        class_name: 'center',
        hpack: 'center',
        spacing: 8,
        children: [Player()],
    });
}

function Right() {
    return Widget.Box({
        class_name: 'right',
        hpack: 'end',
        spacing: 8,
        children: [BacklightSlider(), VolumeSlider(), Sep(), Clock()],
    });
}

function Bar(monitor) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: 'bar',
        monitor,
        layer: 'bottom',
        margins: [6, 6, 0, 6], // [top, right, bottom, left]
        anchor: ['top', 'left', 'right'],
        exclusivity: 'exclusive',
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),

        /*                                            *\
            makes things that rely on on_hover_lost
            behave when exiting the window

            this is to make it so that padding around 
            the window is not needed
        \*                                            */
        setup: (self) =>
            self.on('leave-notify-event', () => {
                volume_reveal.value = false;
                brightness_reveal.value = false;
            }),
    });
}

App.config({
    style: '/tmp/ags.css',
    windows: [Bar(0)],
});

export { };
