{{flutter_js}}
{{flutter_build_config}}

function delay(time) {
    return new Promise(resolve => setTimeout(resolve, time));
}

window.addEventListener('load', (_) => {
    var loader = document.getElementById("loader");
    _flutter.loader.load({
        onEntrypointLoaded: async function (engineInitializer) {
            const appRunner = await engineInitializer.initializeEngine({
                useColorEmoji: true,
            });
            loader.style.scale = "0";
            await delay(0.4);
            await appRunner.runApp();
        }
    });
});