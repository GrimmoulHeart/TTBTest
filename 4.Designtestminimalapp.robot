*** Settings ***
Library    AppiumLibrary
Library    String
Suite Teardown    Run Keywords    Hide Keyboard    Close Application

*** Variables ***
${IPAddress}                 127.0.0.1:4723
${PlatformName}              Android
${PlatformVersion}           10
${DeviceName}                Note9
${AppPackage}                com.avjindersinghsekhon.minimaltodo
${AppActivity}               com.example.avjindersinghsekhon.toodle.MainActivity
${UDID}                      258ce96cd00c7ece
${TitleMinimal}              //android.view.ViewGroup[@resource-id="com.avjindersinghsekhon.minimaltodo:id/toolbar"]/android.widget.TextView
${lblEmptylist}              //android.widget.LinearLayout[@resource-id="com.avjindersinghsekhon.minimaltodo:id/toDoEmptyView"]/android.widget.TextView
${btnOption}                 //android.widget.ImageView[@content-desc="ตัวเลือกเพิ่มเติม"]
${btnSetting}                //android.widget.TextView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/title"]
${chkNightMode}              //android.widget.CheckBox[@resource-id="android:id/checkbox"]
${lblNightmode}              //android.widget.TextView[@resource-id="android:id/title"]
${lbldetailNightmode}        //android.widget.TextView[@resource-id="android:id/summary"]
${btnAddTodoitem}            //android.widget.ImageView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/addToDoItemFAB"]
${lbladdtodotitle}           //bi[@resource-id="com.avjindersinghsekhon.minimaltodo:id/toDoCustomTextInput"]
${txtTodolisttitle}          //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/userToDoEditText"]
${lblRemind}                 //android.widget.TextView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/userToDoRemindMeTextView"]
${btnRemind}                 //android.widget.Switch[@resource-id="com.avjindersinghsekhon.minimaltodo:id/toDoHasDateSwitchCompat"]
${btnSubmit}                 //android.widget.ImageView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton"]
${txtDate}                   //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoDateEditText"]
${txtTime}                   //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoTimeEditText"]
${lbldatetime}               //android.widget.TextView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newToDoDateTimeReminderTextView"]
${lytTodoitem}               //android.widget.RelativeLayout
${lblNametodoitem}           //android.widget.TextView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/toDoListItemTextview"]
${lblDatetodoitem}           //android.widget.TextView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/todoListItemTimeTextView"]
${varNametodoitem}           Morning Run
${varDatetodoitem}           27 พ.ย., 2024
${varTimetodoitem}           6:30

*** Test Cases ***
Open minimal app success
    [Tags]    one
    Open Application minimal todo
    Element Should Contain Text    ${TitleMinimal}    Minimal

minimal app check empty list
    [Tags]    two
    Open Application minimal todo
    Verify Empty List

minimal app night mode on
    [Tags]    three
    Open Application minimal todo
    Go to Setting Menu
    Verify Night Mode On

minimal app night mode off
    [Tags]    four
    Open Application minimal todo
    Go to Setting Menu
    Verify Night Mode Off

minimal app add todo item page success
    [Tags]    five
    Open Application minimal todo
    Go to Page Add Todo Item
    Verify Add Todo Item Page

minimal app add todo list success
    [Tags]    six
    Open Application minimal todo
    Go to Page Add Todo Item
    Create To Do List Item    ${varNametodoitem}    ${varDatetodoitem}    ${varTimetodoitem}
    Verify To Do List Item Main Page

*** Keywords ***
Open Application minimal todo
    Open Application    http://${IPAddress}/wd/hub    platformName=${PlatformName}    platformVersion=${PlatformVersion}    deviceName=${DeviceName}    appPackage=${AppPackage}    appActivity=${AppActivity}    automationName=UiAutomator2    udid=${UDID}    noReset=true    appWaitActivity=*
    Wait Until Element Is Visible     ${TitleMinimal}    30s

Verify Empty List
    Element Should Contain Text    ${TitleMinimal}    Minimal
    Element Should Contain Text    ${lblEmptylist}    You don't have any todos

Go to Setting Menu
    Click Element    ${btnOption}
    Wait Until Element Is Visible     ${btnSetting}    30s
    Click Element    ${btnSetting}
    Wait Until Element Is Visible     ${chkNightMode}    30s

Verify Night Mode On
    Element Should Contain Text    ${lbldetailNightmode}    Night mode is off
    Click Element    ${chkNightMode}
    Sleep    2s
    Element Should Contain Text    ${lbldetailNightmode}    Night mode is on

Verify Night Mode Off
    Element Should Contain Text    ${lbldetailNightmode}    Night mode is on
    Click Element    ${chkNightMode}
    Sleep    2s
    Element Should Contain Text    ${lbldetailNightmode}    Night mode is off

Go to Page Add Todo Item
    Click Element    ${btnAddTodoitem}
    Wait Until Element Is Visible     ${txtTodolisttitle}    30s
    Element Should Contain Text    ${lbladdtodotitle}    Title

Verify Add Todo Item Page
    Element Should Contain Text    ${lblRemind}    Remind Me

Create To Do List Item
    [Arguments]    ${Title}    ${Date}    ${Time}
    Input Text    ${txtTodolisttitle}    ${Title}
    Hide Keyboard
    Element Should Contain Text    ${lblRemind}    Remind Me
    Click Element    ${btnRemind}
    Input Text    ${txtDate}    ${Date}
    Clear Text    ${txtTime}
    Input Text    ${txtTime}    ${Time}
    Hide Keyboard
    Click Element    ${lblRemind}
    Click Element    ${btnSubmit}

Verify To Do List Item Main Page
    Wait Until Element Is Visible    ${lytTodoitem}    30s
    Element Should Contain Text    ${lblNametodoitem}    ${varNametodoitem}