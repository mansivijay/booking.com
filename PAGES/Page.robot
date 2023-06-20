*** Settings ***
Library             SeleniumLibrary
Library             DateTime
Library             AutoItLibrary
Library             WhiteLibrary
Library             SikuliLibrary
Library             Screenshot
Library             Collections
Library             BuiltIn
Library             String
Library             DateTime
Variables           ${EXECDIR}${/}RESOURCES/LOCATORS/LOCATORS.yaml
Variables           ${EXECDIR}${/}RESOURCES/VARIABLES/GLOBALS.yaml
Variables           ${EXECDIR}${/}RESOURCES/VARIABLES/TEST_DATA.yaml
Library             AutoItLibrary

Variables           ${EXECDIR}${/}RESOURCES/LOCATORS/LOCATORS.yaml
Variables           ${EXECDIR}${/}RESOURCES/VARIABLES/GLOBALS.yaml
Variables           ${EXECDIR}${/}RESOURCES/VARIABLES/TEST_DATA.yaml

*** Keywords ***

verify_that_booking_dot_com_main_page_is_launched_succesfully
    [Documentation]     verify that booking.com application is launched succesfully
    SeleniumLibrary.Page Should Contain Element       ${home_page.logo}       ${DATA.TIMEOUT}
    SeleniumLibrary.Page Should Contain Element       ${home_page.flight_hotel}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    Log         Booking.com Website Home Page Launched successfully.

launching_flights_and_hotels_page
    [Documentation]    Launching Agoda flights and hotels
    SeleniumLibrary.Page Should Contain Element       ${home_page.flight_hotel}       ${DATA.TIMEOUT}
    Log     Clicking Flights and Hotel Link
    SeleniumLibrary.CLick Link          ${home_page.flight_hotel}
    Log     Flights and Hotel Link Clicked
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Wait Until Element Is Visible       ${agoda_booking_page.agoda_logo}       ${DATA.TIMEOUT}
    SeleniumLibrary.Wait Until Element Is Visible       ${agoda_booking_page.booking_logo}       ${DATA.TIMEOUT}
    Log     Agoda Booking page launched

getting_tomorrow_date
    ${curr_date}        DateTime.Get Current Date       result_format=%a %b %d %Y
    Log     ${curr_date}
    ${date} =    Get Current Date    result_format=%a %b %d %Y    increment=1 day
    Log    ${date}
    set test variable  ${next_date}  ${date}


getting_after_7_days_date
    ${curr_date}        DateTime.Get Current Date       result_format=%a %b %d %Y
    Log     ${curr_date}
    ${date} =    Get Current Date    result_format=%a %b %d %Y    increment=7 day
    Log    ${date}
    set test variable  ${after_7_date}  ${date}

searching_flights_and_hotel
    [Documentation]    Searching Flights and Hotels
    getting_tomorrow_date
    getting_after_7_days_date
    SeleniumLibrary.Capture Page Screenshot
    Log     Enter flying from location
    SeleniumLibrary.Wait Until Element Is Visible           ${agoda_booking_page.flying_from}       ${DATA.TIMEOUT}
    SeleniumLibrary.Click Element               ${agoda_booking_page.flying_from}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Press Keys                  ${agoda_booking_page.flying_from}       ${search.flight_from}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Click Element               ${agoda_booking_page.airport_from}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Press Keys                  ${agoda_booking_page.flying_to}         ${search.flight_to}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Click Element               ${agoda_booking_page.airport_to}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Wait Until Element Is Visible           ${agoda_booking_page.departure}       ${DATA.TIMEOUT}
    SeleniumLibrary.Double Click Element               ${agoda_booking_page.departure}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Wait Until Element Is Visible           //div[@aria-label="${next_date}"]       ${DATA.TIMEOUT}
    SeleniumLibrary.Click Element           //div[@aria-label="${next_date}"]
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Wait Until Element Is Visible           //div[@aria-label="${after_7_date}"]       ${DATA.TIMEOUT}
    SeleniumLibrary.Click Element           //div[@aria-label="${after_7_date}"]
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.CLick Element           ${agoda_booking_page.search_flight_hotel_btn}
    Sleep   10s
    SeleniumLibrary.Wait Until Element Is Visible           ${agoda_booking_page.hotel_check_in_popup}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.CLick Element           ${agoda_booking_page.hotel_popup_ok_btn}
    SeleniumLibrary.Wait Until Element Is Visible           ${agoda_booking_page.trip_from_to}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    Log     Hotel List displayed

select_hotel_from_displayed_hotel_list
    [Documentation]     Select hotel from hotel list
    SeleniumLibrary.Wait Until Element Is Visible           ${hotel_selection.select_hotel}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Scroll Element Into View                ${hotel_selection.select_hotel}
#    SeleniumLibrary.Wait Until Element Is Visible           ${hotel_selection.select_hotel}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    ${hotel_and_flight_price}    SeleniumLibrary.Get Element Attribute       ${hotel_selection.price_displayed}      data-element-amount
    ${str}  String.Remove String    ${hotel_and_flight_price}    ,
    set test variable       ${hotel_and_flight_price}    ${str}
    Log     ${hotel_and_flight_price}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Click Button                            ${hotel_selection.select_room_btn}
    SeleniumLibrary.Capture Page Screenshot
    Log     Select Room button for hotel is clicked
    SeleniumLibrary.Switch Window         new
    SeleniumLibrary.Wait Until Element Is Visible           ${hotel_selection.select_your_room}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    Log     Hotel selected

select_hotel_room
    [Documentation]     Select Hotel room
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Wait Until Element Is Visible           ${room_selection.room}     ${DATA.TIMEOUT}
#    SeleniumLibrary.Click Button                            ${room_selection.room_btn}
    SeleniumLibrary.Scroll Element Into View                ${room_selection.select_your_room}
    SeleniumLibrary.Scroll Element Into View                ${room_selection.room_count}
    SeleniumLibrary.Wait Until Element Is Visible           ${room_selection.room}       ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    ${room_price}   SeleniumLibrary.Get Text              ${room_selection.room_price_per_person}
    ${str}  String.Remove String    ${room_price}    Rs.
    set test variable       ${room_price}    ${str}
    Log     ${room_price}
    SeleniumLibrary.Scroll Element Into View    ${room_selection.book_now_btn}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Click Button            ${room_selection.book_now_btn}
    SeleniumLibrary.Wait Until Element Is Visible       ${flight_selection.chng_your_flight}    ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    Log     Room selected

select_flight
    [Documentation]     Select Cheapest flight
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Wait Until Element Is Visible       ${flight_selection.booking_summary}    ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot
    ${flight_and_room_price}    SeleniumLibrary.Get Text        ${flight_selection.flight_and_room_price}
    ${str}  String.Remove String    ${flight_and_room_price}    ,
    set test variable       ${flight_and_room_price}    ${str}
    Log     ${flight_and_room_price}
    SeleniumLibrary.Click Button        ${flight_selection.book_btn}
    Log     Book button clicked
    SeleniumLibrary.Wait Until Element Is Visible       ${customer_inf.customer_information}    ${DATA.TIMEOUT}
    SeleniumLibrary.Capture Page Screenshot

#add_customer_information
#    [Documentation]     Add Customer Information
#    SeleniumLibrary.Wait Until Element Is Visible       ${customer_inf.customer_information}    ${DATA.TIMEOUT}
#    SeleniumLibrary.Capture Page Screenshot
#    SeleniumLibrary.Input Text              ${customer_inf.first_name}      ${customer_information.first_name}
#    SeleniumLibrary.Input Text              ${customer_inf.last_name}       ${customer_information.last_name}
#    SeleniumLibrary.Input Text              ${customer_inf.email}           ${customer_information.email}
#    SeleniumLibrary.Click Element               ${customer_inf.country}
#    SeleniumLibrary.Click Element           ${customer_inf.country_india}
#    SeleniumLibrary.Click Element               ${customer_inf.country_code}
#    SeleniumLibrary.Click Element           ${customer_inf.country_code_india}
#    SeleniumLibrary.Input Text              ${customer_inf.mobile_number}    ${customer_information.mobile_number}
#    SeleniumLibrary.Capture Page Screenshot
#    Log         Customer Information is added

#add_passenger_1_information
#    SeleniumLibrary.Scroll Element Into View        ${passender_1.gender.female}
#    SeleniumLibrary.Capture Page Screenshot
#    SeleniumLibrary.Select Radio Button     ${passender_1.gender.female}        1

validate_prices
    Log     ${hotel_and_flight_price}
    Log     ${room_price}
    Log     ${flight_and_room_price}
    Sleep   30s
    SeleniumLibrary.Scroll Element Into View        ${price.total_pay}
    ${total_price}  SeleniumLibrary.Get Text        ${price.total}
    Log     ${total_price}
    ${str}  String.Remove String    ${total_price}    Rs.   ,
    set test variable       ${total_price}    ${str}
    Log     ${flight_and_room_price}
    ${price_display_at_search}    Evaluate    ${hotel_and_flight_price} + ${room_price}
    Log     ${price_display_at_search}
    Log     ${total_price}
    Log     Price displayed at search is same as displayed at confirmation



















