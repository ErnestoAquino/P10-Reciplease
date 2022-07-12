//
//  RecipeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 12/07/2022.
//

import XCTest
@testable import Reciplease

class RecipeServiceTestCase: XCTestCase {

    var mockDelegate: RecipeServiceMockDelegate?

    override func setUp() {
        mockDelegate = RecipeServiceMockDelegate()
    }

    func testGivenEmptyIngredientList_WhenGetRecipes_ThenWarningMessageShouldBeCalled() {
        guard let mockDelegate = mockDelegate else { return }
        //Given
        let recipeService = RecipeService()
        recipeService.listIngredients = []
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
        let stringWithThreeIngredients = "apple, sugar, lemon, sel"
        // When
        recipeService.addIngredients(stringWithThreeIngredients)
        //Then
        XCTAssertTrue(recipeService.listIngredients.count == 4)
        XCTAssertEqual(recipeService.listIngredients[0], "apple")
        XCTAssertEqual(recipeService.listIngredients[1], "sugar")
        XCTAssertEqual(recipeService.listIngredients[2], "lemon")
        XCTAssertEqual(recipeService.listIngredients[3], "sel")
    }
}


//given string with three comma separated ingredients
//when I do addIngredient
//then I should have three ingredients added.
