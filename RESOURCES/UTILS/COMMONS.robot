*** Settings ***

Variables       ${EXECDIR}${/}RESOURCES/LOCATORS/LOCATORS.yaml
Variables       ${EXECDIR}${/}RESOURCES/VARIABLES/GLOBALS.yaml
Variables       ${EXECDIR}${/}RESOURCES/VARIABLES/TEST_DATA.yaml

Library         SeleniumLibrary
Library         BuiltIn
Library         String


*** Keywords ***
open_and_maximize_browser_url
    [Documentation]     Open and maximize browser for url and launch application
    SeleniumLibrary.Open Browser         ${DATA.URL}     ${DATA.CHROME}        ${DATA.TIMEOUT}
    SeleniumLibrary.Maximize Browser Window
    Log         Browser opened and maximized successfully
    SeleniumLibrary.Log Title
    SeleniumLibrary.Title Should be     ${DATA.TITLE}
    SeleniumLibrary.Wait Until Element Is Visible       ${home_page.genius_popup}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    Log         Genius popup opened
    Log         Booking.com Website Launched successfully.

close_genius_popup
    [Documentation]     Close opened Genius Popup
    SeleniumLibrary.Wait Until Element Is Visible       ${home_page.genius_popup}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    Log         Genius popup opened
    SeleniumLibrary.Click Button        ${home_page.genius_popup_close_btn}
    SeleniumLibrary.Wait Until Element Is Not Visible       ${home_page.genius_popup}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Wait Until Element Is Visible       ${home_page.logo}       ${DATA.TIMEOUT}
    Log         Genius popup closed
    Log         Booking.com Website Home Page Launched successfully.


#close_open_session
#    [Documentation]     Close application
#    SeleniumLibrary.Close All Browsers
#    Log         Application closed succesfully

