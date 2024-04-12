import { audio } from "./variables.js"

export function Clock(date) {
    return Widget.Label({
        class_name: 'clock',
        label: `${date.bind()}`,
    })
}

export function Battery(service) {
    return Widget.Box({
        class_name: 'battery',
        children: [
            Widget.CircularProgress({
                child: Widget.Icon({
                    icon: `battery-inner-circle-symbolic`,
                    size: 50,
                    class_name: 'inner',
                }),
                class_name: 'circle',
                visible: service.bind('available'),
                rounded: false,
                inverted: false,
                startAt: 0.75,
                value: service.bind('percent').as((p) => (p > 0 ? p / 100 : 0)),
            }),
        ],
    })
}

export function Sep() {
    return Widget.Label({
        class_name: 'sep',
        label: '|',
    })
}

export function RevealingSlider(slider, icon, click_command) {
    return Widget.EventBox({
        on_hover: () => (`${slider}`.value = true),
        on_hover_lost: () => (`${slider}`.value = false),
        child: Widget.Box({
            spacing: 3,
            vertical: false,
            children: [
                Widget.Button({
                    on_clicked: () => `${click_command}`,
                    child: `${icon}`,
                }),
            ],
        }),
    })
}
