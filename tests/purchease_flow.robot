*** Settings ***

Resource    ../resources/routes/user.robot
Resource    ../resources/routes/product.robot
Resource    ../resources/routes/cart.robot

Suite Setup    Open Browser    about:blank


*** Test Cases ***

Complete purchase flow
    Given Creates the user data request
    When Create the user
    Then Check if the user was created
    And Login with user credentias
    
    Given Creates the product data request
    When Create the products
    Then Check if the product was created
    
    Given Select products to purchase
    When Register the cart with the selected products
    Then The cart must be registered successfully

    Given Complete the shopping cart
    When The cart is completed successfully
    Then Quantities must be debited from stock