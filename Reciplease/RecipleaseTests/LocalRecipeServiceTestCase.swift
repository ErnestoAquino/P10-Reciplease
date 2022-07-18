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
        let fakeCoreDataStack = FakeCoreDataStack()
        let testlocalRecipeService = LocalRecipeService(mainContext: fakeCoreDataStack.mainContext)
        //Given
        let recipeForTest = LocalRecipe(image: nil,
                                 name: "recipe name",
                                 portions: "5",
                                 preparationTime: "15",
                                 ingredientsDetail: [],
                                 urlImage: "www.urlTest.com",
                                 sourceUrl: "www.sourceURLTest")
        //When
        testlocalRecipeService.saveRecipe(recipeForTest)
        testlocalRecipeService.fetchRecipes()
        //Then
        XCTAssertTrue(testlocalRecipeService.favoriteRecipes.count == 1)
    }

    func testGivenLocalRecipeNil_WhenIUseSaveRecipe_ThenFavoritesRecipesShouldBeEmpty() {
        let fakeCoreData = FakeCoreDataStack()
        let testLocalRecipe = LocalRecipeService(mainContext: fakeCoreData.mainContext)
        // Given
        let recipeNill: LocalRecipe? = nil
        //When
        testLocalRecipe.saveRecipe(recipeNill)
        testLocalRecipe.fetchRecipes()
        //Then
        XCTAssertTrue(testLocalRecipe.favoriteRecipes.isEmpty)
    }

    func testGivenThreeStoredRecipes_WhenIUseFetchRecipes_ThenShouldHaveThreeRecipes() {
        let fakeCoreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: fakeCoreData.mainContext)
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

    func testGivenThreeStoredRecipes_WhenIDeleteARecipe_ThenShouldHaveTwoRecipes() async {
        let exp = expectation(description: "wait for Core Data")
        let fakeCoreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: fakeCoreData.mainContext)
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
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //When
        let recipeToDelete = localRecipeService.favoriteRecipes[0]
        localRecipeService.deleteRecipe(recipe: recipeToDelete)
        //Then
        XCTAssertTrue(localRecipeService.favoriteRecipes.count == 2)
    }

    func testGivenThreeStoredRecipes_WhenIDeleteARecipeNil_ThenShouldHaveThreeRecipes() async {
        let exp = expectation(description: "wait for Core Data")
        let fakeCoreData = FakeCoreDataStack()
        let localRecipeService = LocalRecipeService(mainContext: fakeCoreData.mainContext)
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
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //When
        let recipeToDelete: FavoriteRecipe? = nil
        localRecipeService.deleteRecipe(recipe: recipeToDelete)
        //Then
        XCTAssertTrue(localRecipeService.favoriteRecipes.count == 3)
    }
}
