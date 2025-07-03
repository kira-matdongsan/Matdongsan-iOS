//
//  DishNameInputModalView_UITests.swift
//  Matdongsan_UITests
//
//  Created by sujeong on 7/3/25.
//

import XCTest

// naming structure: test_unitofwork(struct or class)_stateundertest(ui component)_expectedBehavior(result)
// testing structure: given when then

final class DishNameInputModalView_UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
//        let app = XCUIApplication()
//        app.launch()
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func test_DishNameInputModalView_doneButton_shouldBeDisabled() {
        // given
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["🌽 옥수수 제철음식 상세화면"]/*[[".otherElements.buttons[\"🌽 옥수수 제철음식 상세화면\"]",".buttons[\"🌽 옥수수 제철음식 상세화면\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["투표기간 | 25.07.07~25.07.13"]/*[[".otherElements.staticTexts[\"투표기간 | 25.07.07~25.07.13\"]",".staticTexts[\"투표기간 | 25.07.07~25.07.13\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        let label = app/*@START_MENU_TOKEN@*/.staticTexts["나의 제철음식 이야기"]/*[[".otherElements.staticTexts[\"나의 제철음식 이야기\"]",".staticTexts[\"나의 제철음식 이야기\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        while !(label.exists) {
            app.swipeUp()
        }
        app.buttons["2, 6명이 선택했어요., 찐옥수수"].swipeLeft()
        app.buttons["5, 6명이 선택했어요., 찐옥수수"].swipeLeft()
        app.buttons["8, 6명이 선택했어요., 찐옥수수"].swipeLeft()
        app/*@START_MENU_TOKEN@*/.buttons["좋아하는 제철요리가 여기 없나요?, 제철요리 등록하기"]/*[[".buttons",".containing(.image, identifier: \"add_food_img\").firstMatch",".containing(.staticText, identifier: \"제철요리 등록하기\").firstMatch",".containing(.staticText, identifier: \"좋아하는 제철요리가 여기 없나요?\").firstMatch",".cells.buttons.firstMatch",".otherElements.buttons[\"좋아하는 제철요리가 여기 없나요?, 제철요리 등록하기\"]",".buttons[\"좋아하는 제철요리가 여기 없나요?, 제철요리 등록하기\"]"],[[[-1,6],[-1,5],[-1,4],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
                
        app/*@START_MENU_TOKEN@*/.buttons.staticTexts["제철요리 추가하기"]/*[[".buttons[\"제철요리 추가하기\"].staticTexts.firstMatch",".buttons.staticTexts[\"제철요리 추가하기\"]",".staticTexts[\"제철요리 추가하기\"]"],[[[-1,2],[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["추가하기"]/*[[".otherElements.buttons[\"추가하기\"]",".buttons[\"추가하기\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
               
        let textField = app/*@START_MENU_TOKEN@*/.textFields["제철요리 이름을 입력해 주세요. (최대 22자)"]/*[[".otherElements.textFields[\"제철요리 이름을 입력해 주세요. (최대 22자)\"]",".textFields.firstMatch",".textFields[\"제철요리 이름을 입력해 주세요. (최대 22자)\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let addButton = app/*@START_MENU_TOKEN@*/.buttons["추가하기"]/*[[".otherElements.buttons[\"추가하기\"]",".buttons[\"추가하기\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        // when
        textField.tap()
        addButton.tap()
        
        // then
        XCTAssertFalse(addButton.isEnabled)
    }
    
    
}
