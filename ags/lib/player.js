const mpris = await Service.import('mpris');

let active_player = Variable(mpris.getPlayer(''));
mpris.connect('player-changed', (mpris, bus) => {
    mpris.getPlayer(bus).connect('changed', (player) => {
        active_player.value = player;
        print(active_player.value.track_title);
    });
});

function GetActivePlayer() {
    if (active_player.value != null) {
        print('good');
    } else {
        print('bad');
    }

    return active_player.value != null ? 'good' : 'bad';
}

function PlayerLabel() {
    return Widget.Label({
        max_width_chars: 36,
        truncate: 'end',
        justification: 'left',
        wrap: false,
        use_markup: false,
        label: GetActivePlayer(),
    });
}

export function Player() {
    return Widget.EventBox({
        child: Widget.Box({
            spacing: 0,
            children: [
                Widget.Revealer({
                    setup: (self) =>
                        self.hook(mpris, () => {
                            const reveal = mpris.getPlayer('');
                            self.reveal_child = !reveal;
                        }),
                    transition_duration: 350,
                    transition: 'slide_right',
                    child: Widget.Label({
                        label: '(^°○°)^',
                    }),
                }),
                Widget.Revealer({
                    setup: (self) =>
                        self.hook(mpris, () => {
                            const reveal = mpris.getPlayer('');
                            self.reveal_child = reveal;
                        }),
                    transition_duration: 350,
                    transition: 'slide_left',
                    child: Widget.Box({
                        vertical: false,
                        children: [PlayerLabel()],
                    }),
                }),
            ],
        }),
    });
}
