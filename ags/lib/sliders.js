const audio = await Service.import('audio');
import backlight from './service/backlight.js';

/*                                                *\
    export so that they can be used in config.js
    to change when the bar loses focus
\*                                                */
export const volume_reveal = Variable(false);
export const brightness_reveal = Variable(false);

function RevealingSlider(reveal, icon, click_command, slider) {
    return Widget.EventBox({
        class_name: 'revealing_slider',
        on_hover: () => (reveal.value = true),
        on_hover_lost: () =>
            Utils.timeout(250, () => {
                reveal.value = false;
            }),

        child: Widget.Box({
            spacing: 3,
            vertical: false,
            children: [
                Widget.Button({
                    on_clicked: () => Utils.execAsync(['sh', '-c', `${click_command}`]),
                    child: icon,
                }),
                Widget.Revealer({
                    reveal_child: reveal.bind(),
                    transition_duration: 350,
                    transition: 'slide_left',
                    child: slider,
                }),
            ],
        }),
    });
}

export function VolumeSlider() {
    return RevealingSlider(
        volume_reveal,
        Widget.Icon().hook(audio['speaker'], (self) => {
            const vol = audio['speaker'].volume * 100;
            const icon = [
                [101, 'overamplified'],
                [67, 'high'],
                [34, 'medium'],
                [0, 'low'],
            ].find(([threshold]) => threshold <= vol)?.[1];

            self.class_name = 'icon';
            self.icon = audio['speaker'].is_muted
                ? 'volume-muted-symbolic'
                : `volume-${icon}-symbolic`;
        }),
        'wpctl set-mute @DEFAULT_SINK@ toggle',
        Widget.Slider({
            class_name: 'slider',
            vertical: false,
            value: audio['speaker'].bind('volume'),
            draw_value: false,
            min: 0,
            max: 1,
            on_change: ({ value }) => (audio['speaker'].volume = value),
        })
    );
}

export function BacklightSlider() {
    return RevealingSlider(
        brightness_reveal,
        Widget.Icon().hook(backlight, (self) => {
            const brightness = backlight.brightness * 100;
            const icon = [
                [65, 'high'],
                [0, 'low'],
            ].find(([threshold]) => threshold <= brightness)?.[1];

            self.class_name = 'icon';
            self.icon = `brightness-${icon}-symbolic`;
        }),
        '',
        Widget.Slider({
            class_name: 'slider',
            vertical: false,
            value: backlight.bind('brightness'),
            draw_value: false,
            min: 0,
            max: 1,
            on_change: ({ value }) => (backlight.brightness = value),
        })
    );
}
