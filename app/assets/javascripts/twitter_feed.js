function loadTwitter() {
    new TWTR.Widget({
        version: 2,
        type: 'profile',
        rpp: 4,
        interval: 30000,
        width: 270,
        height: 400,
        theme: {
            shell: {
                background: '#333333',
                color: '#ffffff'
            },
            tweets: {
                background: '#000000',
                color: '#ffffff',
                links: '#408bdb'
            }
        },
        features: {
            scrollbar: true,
            loop: false,
            live: true,
            behavior: 'all'
        }
    }).render().setUser('undergroundmed').start();

}