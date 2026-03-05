if not Config.Drugs['whippit'] then return end
Config.Whippit = {
    Recipes = {
        cracker = {
            {color = 'blue',    item = 'blue_uninflated_balloon'},
            {color = 'green',   item = 'green_uninflated_balloon'},
            {color = 'orange',  item = 'orange_uninflated_balloon'},
            {color = 'purple',  item = 'purple_uninflated_balloon'},
            {color = 'red',     item = 'red_uninflated_balloon'},
            {color = 'white',   item = 'white_uninflated_balloon'},
            {color = 'yellow',  item = 'yellow_uninflated_balloon'}
        },
        shop = {
            blue_uninflated_balloon =5,
            green_uninflated_balloon =5,
            orange_uninflated_balloon =5,
            purple_uninflated_balloon =5,
            red_uninflated_balloon =5,
            white_uninflated_balloon =5,
            yellow_uninflated_balloon =5,
            cracker =500,
            whipped_cream_cannister =10
        }
    },
    Locations = {
        Whippit = {
            {loc =vector4(1695.47, 4872.98, 42.16, 288.86), ped = 'ig_priest' },
        }
    }
}