[![forthebadge](https://forthebadge.com/images/badges/made-with-swift.svg)](https://forthebadge.com)[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
### Author: *Ernesto Elias Aquino Cifuentes*
# P10 - Reciplease
 ##  Simple recipe application.
 Project number 10 of the formation: [iOS Application Developer.](https://openclassrooms.com/fr/paths/69-developpeur-dapplication-ios#path-tabs "iOS Application Developer.")
 
This application allows the search of recipes using the API provided by [EDAMAM](https://www.edamam.com "EDAMAM").

## How Use:
In the search page you can add the ingredients one by one or separated by a comma like this: apple, lemon, sugar.
The search results are displayed in a tableView and the details view allows you to consult:
- The photo of the recipe (or a default image if it is unavailable).
- The general list of ingredients.
- Number of servings, if available.
- Preparation time if available.

The "get directions" button allows you to open the browser and access the full details of the recipe.
The " ♡ " button allows you to add the recipe to be saved as a favorite recipe.

## Configuration
To use the application you have to create a .xcconfig file with the following:
> API_KEY = yourApiKeyHere

And then you have to add it into the info.plist
For more details, please consult [article](https://medium.com/swift-india/secure-secrets-in-ios-app-9f66085800b4 "article").


![Simulator Screen Shot - iPhone 13 Pro Max - 2022-07-21 at 15 24 07](https://user-images.githubusercontent.com/88657406/180226681-8d365139-0abb-4da4-961f-3126bdf857ad.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-07-21 at 15 24 15](https://user-images.githubusercontent.com/88657406/180226712-f1d5f837-ef06-4211-b3d3-298c23ab8ac6.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-07-21 at 15 24 22](https://user-images.githubusercontent.com/88657406/180226726-d2d0fc29-6fcb-4254-9cb0-40748fa0e70e.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-07-21 at 15 24 30](https://user-images.githubusercontent.com/88657406/180226739-f650147e-b20c-446f-8cf2-9ca4847a4b80.png)
