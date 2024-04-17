const battery = await Service.import('battery')
const bar_reveal = Variable(false)

// circular battery indicator
export function Battery_Circle() {
    return Widget.Box({
        class_name: 'battery circle',
        spacing: 3,
        children: [
            Widget.CircularProgress({
                child: Widget.Icon({
                    icon: `battery-inner-circle-symbolic`,
                    size: 50,
                    class_name: 'inner',
                }),
                class_name: 'outer',
                visible: battery.bind('available'),
                rounded: false,
                inverted: false,
                startAt: 0.75,
                value: battery.bind('percent').as((p) => (p > 0 ? p / 100 : 0)),
            }),
        ],
    })
}

// bar battery indicator
export function Battery_Bar() {
    return Widget.EventBox({
        class_name: 'battery bar',
        on_hover: () => (bar_reveal.value = true),

        // workaround to on_hover_lost needing the window to still be focused
        setup: (self) =>
            self.on('leave-notify-event', () => {
                bar_reveal.value = false
            }),

        child: Widget.Box({
            vertical: false,
            spacing: 3,
            children: [
                Widget.Icon({
                    class_name: 'icon',
                    icon: `battery-icon-symbolic`,
                }),
                Widget.Revealer({
                    reveal_child: bar_reveal.bind(),
                    transition: 'slide_left',
                    child: Widget.LevelBar({
                        vertical: false,
                        bar_mode: 'discrete',
                        max_value: 10,
                        value: battery.bind('percent').as((p) => (p > 0 ? p / 10 : 0)),
                    }),
                }),
            ],
        }),
    })
}
