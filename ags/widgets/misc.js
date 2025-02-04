export const Seperator = ({ vertical = true }) =>
    Widget.Separator({
        class_name: 'seperator',
        vertical: vertical,
    });

export const Padding = (hexpand = true, vexpand = true) =>
    Widget.Box({
        hexpand,
        vexpand,
        can_focus: false,
    });

export const Column = ({ children, class_name = '', ...rest }) =>
    Widget.Box({
        class_names: ['column', class_name],
        vertical: true,
        children: children,
        ...rest,
    });

export const Row = ({ children, class_name = '', ...rest }) =>
    Widget.Box({
        class_names: ['row', class_name],
        vertical: false,
        children: children,
        ...rest,
    });

export const opened = {
    menu: Variable(''),
    popout: Variable(''),
};
App.connect('window-toggled', (_, name, visible) => {
    if (name === 'control-centre' && !visible)
        Utils.timeout(500, () =>
            Object.keys(opened).forEach(function(key) {
                opened[key].value = '';
            })
        );
});
