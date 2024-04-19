/** @returns true if all of the `bins` are found */
export function dependencies(...bins) {
    const missing = bins.filter((bin) => {
        return !Utils.exec(`which ${bin}`);
    });

    if (missing.length > 0) {
        console.warn('missing dependencies:', missing.join(', '));
        Utils.notify(`missing dependencies: ${missing.join(', ')}`);
    }

    return missing.length === 0;
}
