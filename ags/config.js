// compile, reset, apply
Utils.exec('sassc style/main.scss /tmp/ags.css')

// custom icons
App.addIcons(`${App.configDir}/assets`)

import * as widgets from './lib/widgets.js'
import * as values from './lib/variables.js'

// layout of the bar
function Left() {
    return Widget.Box({
        class_name: 'left',
        hpack: 'start',
        spacing: 8,
        children: [widgets.Battery(values.battery)],
    })
}

function Center() {
    return Widget.Box({
        class_name: 'center',
        hpack: 'center',
        spacing: 8,
        children: [],
    })
}

function Right() {
    return Widget.Box({
        class_name: 'right',
        hpack: 'end',
        spacing: 8,
        children: [
            widgets.default(
                values.volume_reveal,
                values.volume_icon,
                `wpctl set-mute @DEFAULT_SINK@ toggle`
            ),
            widgets.Sep(),
            widgets.Clock(values.date),
        ],
    })
}

function Bar(monitor) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: 'bar',
        monitor,
        layer: 'bottom',
        margins: [6, 6, 0, 6], // top right bottom left
        anchor: ['top', 'left', 'right'],
        exclusivity: 'exclusive',
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}

App.config({
    style: '/tmp/ags.css',
    windows: [Bar(0)],
})

export { }
