function loadTwitter() {
    new TWTR.Widget({
        version: 2,
        type: 'profile',
        rpp: 4,
        interval: 30000,
        width: 200,
        height: 150,
        theme: {
            shell: {
                background: '#dddddd',
                color: '#aaaaaa'
            },
            tweets: {
                background: 'white',
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