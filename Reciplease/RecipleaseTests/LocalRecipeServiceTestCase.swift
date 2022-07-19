//
//  LocalRecipeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 17/07/2022.
//

import XCTest
import CoreData
@testable import Reciplease



class LocalRecipeServiceTestCase: XCTestCase {

    func testGivenLocalRecipe_WhenIUseSaveRecipe_ThenTheRecipeShouldBeSaved()  {
        let coreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: coreData.mainContext)
        //Given
        let recipeForTest = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        //When
        localRecipeService.saveRecipe(recipeForTest)
        localRecipeService.fetchRecipes()
        //Then
        XCTAssertTrue(localRecipeService.favoriteRecipes.count == 1)
    }

    func testGivenLocalRecipeNil_WhenIUseSaveRecipe_ThenFavoritesRecipesShouldBeEmpty() {
        let coreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: coreData.mainContext)
        // Given
        let recipeNill: LocalRecipe? = nil
        //When
        localRecipeService.saveRecipe(recipeNill)
        localRecipeService.fetchRecipes()
        //Then
        XCTAssertTrue(localRecipeService.favoriteRecipes.isEmpty)
    }

    func testGivenThreeStoredRecipes_WhenIUseFetchRecipes_ThenShouldHaveThreeRecipes() {
        let coreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: coreData.mainContext)
        let recipeOne = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        let recipeTwo = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        let recipeThree = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        localRecipeService.saveRecipe(recipeOne)
        localRecipeService.saveRecipe(recipeTwo)
        localRecipeService.saveRecipe(recipeThree)

        //When
        localRecipeService.fetchRecipes()
        //Then
        XCTAssertTrue(localRecipeService.favoriteRecipes.count == 3)
    }

    func testGivenThreeStoredRecipes_WhenIDeleteARecipe_ThenShouldHaveTwoRecipes()  {
        let coreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: coreData.mainContext)
        let recipeOne = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        let recipeTwo = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        let recipeThree = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        //Given
        localRecipeService.saveRecipe(recipeOne)
        localRecipeService.saveRecipe(recipeTwo)
        localRecipeService.saveRecipe(recipeThree)
        localRecipeService.fetchRecipes()
        //When
        let recipeToDelete = localRecipeService.favoriteRecipes[0]
        localRecipeService.deleteRecipe(recipe: recipeToDelete)
        //Then
        XCTAssertTrue(localRecipeService.favoriteRecipes.count == 2)
    }

    func testGivenThreeStoredRecipes_WhenIDeleteARecipeNil_ThenShouldHaveThreeRecipes() {
        let coreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: coreData.mainContext)
        let recipeOne = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        let recipeTwo = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        let recipeThree = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        //Given
        localRecipeService.saveRecipe(recipeOne)
        localRecipeService.saveRecipe(recipeTwo)
        localRecipeService.saveRecipe(recipeThree)
        localRecipeService.fetchRecipes()
        //When
        let recipeToDelete: FavoriteRecipe? = nil
        localRecipeService.deleteRecipe(recipe: recipeToDelete)
        //Then
        XCTAssertTrue(localRecipeService.favoriteRecipes.count == 3)
    }

    func testGivenASavedRecipe_WhenIFechtTheRecipe_ThenItShouldHaveTheExpectedValues() {
        let coreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: coreData.mainContext)
        let imageExpected = "nil".data(using: .utf8)
        let nameExpected = "NameTest0923kado"
        let portionsExpected = "12"
        let urlImageExpected = "www.iwejiqe923j.com"
        let sourceURLExpected = "www.rweri32930sk.com"

        let recipe = LocalRecipe(image: "nil".data(using: .utf8),
                                 name: "NameTest0923kado",
                                 portions: "12",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.iwejiqe923j.com",
                                 sourceUrl: "www.rweri32930sk.com")
        //Given
        localRecipeService.saveRecipe(recipe)
        //When
        localRecipeService.fetchRecipes()
        //Then
        XCTAssertEqual(localRecipeService.favoriteRecipes[0].image, imageExpected)
        XCTAssertEqual(localRecipeService.favoriteRecipes[0].name, nameExpected)
        XCTAssertEqual(localRecipeService.favoriteRecipes[0].portions, portionsExpected)
        XCTAssertEqual(localRecipeService.favoriteRecipes[0].urlImage, urlImageExpected)
        XCTAssertEqual(localRecipeService.favoriteRecipes[0].sourceUrl, sourceURLExpected)
    }

    func testGivenEmptyFavoriteRecipeList_WhenFechRecipes_ThenListOfFavoritesRecipesShouldBeEmpty() {
        let coreData = FakeCoreDataStack()
        //Given
        let localRecipeService = LocalRecipeService(mainContext: coreData.mainContext)
        //When
        localRecipeService.fetchRecipes()
        //Then
        XCTAssertTrue(localRecipeService.favoriteRecipes.isEmpty)
    }
}

