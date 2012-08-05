function loadTwitter() {
    new TWTR.Widget({
        version: 2,
        type: 'profile',
        rpp: 4,
        interval: 30000,
        width: 200,
        height: 174,
        theme: {
            shell: {
                background: '#f1f1f1',
                color: '#aaaaaa',
            },
            tweets: {
                background: '#f5f7fa',
                color: 'black',
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