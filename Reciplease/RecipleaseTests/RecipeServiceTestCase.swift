//
//  RecipeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 12/07/2022.
//

import XCTest
@testable import Reciplease

/**
 * RecipeServiceTestCase:
 *
 * Tests created for the RecipeService class.
 */
class RecipeServiceTestCase: XCTestCase {

    var mockDelegate: RecipeServiceMockDelegate?

    override func setUp() {
        mockDelegate = RecipeServiceMockDelegate()
    }

    func testGivenEmptyIngredientList_WhenGetRecipes_ThenWarningMessageShouldBeCalled() {
        guard let mockDelegate = mockDelegate else { return }
        //Given
        let recipeService = RecipeService()
        recipeService.clearListIngredient()
        recipeService.viewDelegate = mockDelegate
        //When
        recipeService.getRecipes()
        //Then
        XCTAssertTrue(mockDelegate.warningMessageIsCalled)
    }

    func testGivenAnNilStringHowIngredient_WhenDoAddIngredient_ThenIngredientShouldNotBeAdded() {
        guard let mockDelegate = mockDelegate else { return }
        let recipeService = RecipeService()
        recipeService.listIngredients = []
        recipeService.viewDelegate = mockDelegate
        //Given
        let emptyIngredient: String? = nil
        //When
        recipeService.addIngredients(emptyIngredient)
        //Then
        XCTAssertTrue(recipeService.listIngredients.isEmpty)
    }

    func testGivenStringWithOnlySpaceAsIngredient_WhenDoAddIngredient_ThenIngredientShouldNotBeAdded() {
        let recipeService = RecipeService()
        recipeService.listIngredients = []
        //Given
        let onlySpacesIngredient = "         "
        //When
        recipeService.addIngredients(onlySpacesIngredient)
        //Then
        XCTAssertTrue(recipeService.listIngredients.isEmpty)
    }

    func testGivenAValidIngredient_WhenDoAddIngredient_ThenIngredientShoulgBeAdded() {
        let recipeService = RecipeService()
        recipeService.listIngredients = []
        //Given
        let validIngredient = "apple"
        //When
        recipeService.addIngredients(validIngredient)
        //Then
        XCTAssertEqual(recipeService.listIngredients[0], validIngredient)
    }

    func testGivenStringWithFourCommaSeparatedIngredients_WhenDoAddIngredient_ThenShouldHaveFourIngredients() {
        let recipeService = RecipeService()
        recipeService.listIngredients = []
        //Given
        let stringWithFourIngredients = "apple, sugar, lemon, sel"
        // When
        recipeService.addIngredients(stringWithFourIngredients)
        //Then
        XCTAssertTrue(recipeService.listIngredients.count == 4)
        XCTAssertEqual(recipeService.listIngredients[0], "apple")
        XCTAssertEqual(recipeService.listIngredients[1], "sugar")
        XCTAssertEqual(recipeService.listIngredients[2], "lemon")
        XCTAssertEqual(recipeService.listIngredients[3], "sel")
    }

    func testGivenCorrectResponse_WhenIUseGetRecipes_ThenShouldHaveTheExpectedRecipesNames() async {
        let exp = expectation(description: "Wait for function")
        let recipeNameOne = "Creamy Chicken Sundried Tomates"
        let recipeNameTwo = "Mofongo Con Salsa De Tomate (Mashed Plantains With Tomato Sauce)"
        let recipeNameThree = "Mofongo Con Salsa De Tomate (Mashed Plantains With Tomato Sauce)"
        let recipeNameFour = "Roasted Tomato and Garlic Soup"
        //Given
        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .success)
        let recipeService = RecipeService(recipes: [], nextRexipes: nil, session: session)
        //When
        recipeService.getRecipes()
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertEqual(recipeService.listRecipes[0].name, recipeNameOne)
        XCTAssertEqual(recipeService.listRecipes[1].name, recipeNameTwo)
        XCTAssertEqual(recipeService.listRecipes[2].name, recipeNameThree)
        XCTAssertEqual(recipeService.listRecipes[3].name, recipeNameFour)
    }

    func testGivenErrorInResponse_WhenIUseGetRecipe_ThenRecipeListShouldBeEmpty() async {
        let exp = expectation(description: "Wait for function")
        //Given
        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .failure)
        let recipeService = RecipeService(recipes: [], nextRexipes: nil, session: session)
        //When
        recipeService.getRecipes()
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertTrue(recipeService.listRecipes.isEmpty)
    }

    func testGivenNoMoreResults_WhenIUseGetNextRecipes_ThenIShouldHaveNoRecipes() async {
        let exp = expectation(description: "Wait for function")
        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .success)
        //Given
        let recipesService = RecipeService(recipes: [], nextRexipes: nil, session: session)
        //When
        recipesService.getNextRecipes()
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertTrue(recipesService.listRecipes.isEmpty)
    }

    func testGivenMoreResultsForTheSearch_WhenIUseGetNextsRecipes_ThenShouldHaveFourteenRecipes() async {
        let exp = expectation(description: "Wait for function")
        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .success)
        //Given
        let recipesService = RecipeService(recipes: [], nextRexipes: "url", session: session)
        //When
        recipesService.getNextRecipes()
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertEqual(recipesService.listRecipes.count, 14)
    }

    func testGivenAnErrorInResponse_WhenIUseGetNextRecipes_ThenListOfRecipesShouldBeEmpty () async {
        let exp = expectation(description: "Wait for function")
        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .failure)
        //Given
        let recipesService = RecipeService(recipes: [], nextRexipes: "url", session: session)
        //When
        recipesService.getNextRecipes()
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertTrue(recipesService.listRecipes.isEmpty)
    }

    func testGivenIndexOutOfRange_WhenIUseGetImage_ThenThereShouldBeNoError () async {
        let exp = expectation(description: "Wait for function")
        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .success)
        let recipesService = RecipeService(recipes: [], nextRexipes: "url", session: session)
        //Given
        let indexOutOfRange = 1000
        //When
        recipesService.getImage(index: indexOutOfRange)
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then

    }

    func testGivenARecipeWithoutImage_WhenIUseGetImage_ThenTheRecipeImageShouldBeNotNil () async {
        let exp1 = expectation(description: "Wait for recipeService to fetch the recipes.")
        //Given
        let recipeWithoutImage = LocalRecipe(image: nil,
                                             name: "TestName",
                                             portions: "0",
                                             preparationTime: "0",
                                             ingredientsDetail: [],
                                             urlImage: "fakeURL",
                                             sourceUrl: "fakeSourceURL")

        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .success)
        let recipeService = RecipeService(recipes: [recipeWithoutImage], nextRexipes: "url", session: session)
        //When
        recipeService.getImage(index: 0)
        exp1.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertNotNil(recipeService.listRecipes[0].image)
    }

    func testGivenErrorInResponse_WhenIUseGetRecipeImage_ThenTheRecipeImageShouldBeNil () async {
        let exp = expectation(description: "Wait for recipeService to fetch the recipes.")
        //Given
        let recipeWithoutImage = LocalRecipe(image: nil,
                                             name: "TestName",
                                             portions: "0",
                                             preparationTime: "0",
                                             ingredientsDetail: [],
                                             urlImage: "fakeURL",
                                             sourceUrl: "fakeSourceURL")

        let session = SessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, result: .failure)
        let recipeService = RecipeService(recipes: [recipeWithoutImage], nextRexipes: "url", session: session)
        //When
        recipeService.getImage(index: 0)
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertNil(recipeService.listRecipes[0].image)
    }

    func testGivenResponseWithMissingElements_WhenIUseGetRecipes_ThenShouldHaveDefaultValues() async {
        let exp = expectation(description: "Wait for function")
        let recipeNameDeafult = ""
        let recipePortionDefault = "0 servings\t"
        let recipeTimeDefault = "0 minutes\t"
        //Given
        let session = SessionFake(data: FakeResponse.dataWithMissingElements, response: FakeResponse.responseOK, result: .success)
        let recipeService = RecipeService(recipes: [], nextRexipes: nil, session: session)
        //When
        recipeService.getRecipes()
        exp.fulfill()
        await waitForExpectations(timeout: 3)
        //Then
        print(recipeService.listRecipes.count)
        XCTAssertEqual(recipeService.listRecipes[0].name, recipeNameDeafult)
        XCTAssertEqual(recipeService.listRecipes[0].portions, recipePortionDefault)
        XCTAssertEqual(recipeService.listRecipes[0].preparationTime, recipeTimeDefault)
        XCTAssertTrue(recipeService.listRecipes[0].ingredientsDetail.isEmpty)
    }

    func testGivenResponseWithoutHits_WhenIUseGetRecipes_ThenListOfRecipesShouldBeEmpty() async {
        let exp = expectation(description: "Wait for function")
        let nextRecipesExpected = "https://api.edamam.com/api/recipes/v2?q=tomate%2C%20chicken&app_key=cfa430402075604d56fc1e8c94096b51&field=ingredientLines&field=ingredients&field=totalTime&field=label&field=image&field=url&_cont=CHcWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=f3afe7be"
        //Given
        let session = SessionFake(data: FakeResponse.dataWithoutHits, response: FakeResponse.responseOK, result: .success)
        let recipeService = RecipeService(recipes: [], nextRexipes: nil, session: session)
        //When
        recipeService.getRecipes()
        exp.fulfill()
        await waitForExpectations(timeout: 3)

        XCTAssertTrue(recipeService.listRecipes.isEmpty)
        XCTAssertEqual(recipeService.nextRecipes, nextRecipesExpected)
    }
}

//given response with missing elements
//when I use "getRecipes"
//then you should have the default values
