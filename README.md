[![forthebadge](https://forthebadge.com/images/badges/made-with-swift.svg)](https://forthebadge.com)[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
### Author: *Ernesto Elias Aquino Cifuentes*
# P10 - Reciplease
 ##  Simple recipe application.
 Project number 10 of the formation: [iOS Application Developer.](https://openclassrooms.com/fr/paths/69-developpeur-dapplication-ios#path-tabs "iOS Application Developer.")
 
This application allows the search of recipes using the api provided by [EDAMAM](https://www.edamam.com "EDAMAM").

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
To use the application you have to create an .xcconfig file with the following:
> API_KEY = yourApiKeyHere

And then you have to add  it to the info.plist
If you want a more extensive explanation you can consult this [article](https://medium.com/swift-india/secure-secrets-in-ios-app-9f66085800b4 "article").
