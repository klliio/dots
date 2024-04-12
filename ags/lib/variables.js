export const battery = await Service.import("battery")
export const audio = await Service.import("audio")

export const date = Variable("", {
    poll: [1000, 'date +%H:%M'],
})

export const brightness_reveal = Variable(false)
export const volume_reveal = Variable(false)

// JS ERROR: TypeError: audio.speaker.stream is null
//
// (com.github.Aylur.ags:9349): Gjs-WARNING **: 02:33:36.907: JS ERROR: TypeError: audio.speaker.stream is null
// @file:///home/klliio/.config/ags/lib/variables.js:12:21
// async*_init/GLib.MainLoop.prototype.runAsync/</<@resource:///org/gnome/gjs/modules/core/overrides/GLib.js:266:34
const mute_status = audio.speaker.stream.is_muted.bind();

export const volume_icon = Widget.Icon({
    setup: self => self.hook(mute_status, () => {
        self.icon = `volume-unmute-symbolic`
        if (mute_status) {
            self.icon = `volume-mute-symbolic`
        }
    })
})
