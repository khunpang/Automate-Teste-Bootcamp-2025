*** Settings ***
Library    SeleniumLibrary    

*** Variables ***
${url}    https://www.allonline.7eleven.co.th/
${btn_plus}    //*[@id="article-form"]/div[2]/div[2]/div[1]/span[2]
${name_product}    //*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[2]/div
${check_order}    //*[@id="stepModel"]/div[1]/div[2]

*** Test Cases ***
สั่งซื้อสินค้า ซอยแคท และ มีโอ เลือกรับที่ร้านและชำระเงินด้วยทรูมันนี่ วอลเล็ท
    เปิดเว็บ allonline
    ค้นหาคำว่า ซอยแคท อาหารแมว 1 มิกซ์
    ตรวจสอบผลลัพธ์การค้นหา ซอยแคท อาหารแมว 1 มิกซ์
    เลือกสินค้า ซอยแคท
    เพิ่มจำนวนสินค้า ซอยแคท จำนวน 2 ชิ้น
    กดเพิ่มลงตะกร้า 
    ค้นหาคำว่า มีโอ อาหารแมว ปลาทูน่า
    ตรวจสอบผลลัพธ์การค้นหา มีโอ อาหารแมว ปลาทูน่า
    เลือกสินค้า มีโอ
    กดเพิ่มลงตะกร้า
    กดชำระค่าสินค้า
    login ข้อมูลส่วนตัว
    เลือกจัดส่งที่ร้าน7-11
    ดำเนินการชำระเงิน
    เลือกชำระเงินด้วยทรูมันนี่ วอลเล็ท
    ตรวจสอบสรุุปรายการสั่งซื้อ

*** Keywords ***
เปิดเว็บ allonline
    Open Browser    url=${url}    browser=chrome

ค้นหาคำว่า ซอยแคท อาหารแมว 1 มิกซ์
    Input Text    name=q    ซอยแคท อาหารแมว 1 มิกซ์ 1 กก.
    Press Keys    None    RETURN

ค้นหาคำว่า มีโอ อาหารแมว ปลาทูน่า
    Input Text    name=q    มีโอ อาหารแมว ปลาทูน่า 1 กก.
    Press Keys    None    RETURN

ตรวจสอบผลลัพธ์การค้นหา ซอยแคท อาหารแมว 1 มิกซ์
    Wait Until Element Is Visible    xpath=${name_product}
    Element Should Contain    xpath=${name_product}    ซอยแคท อาหารแมว 1 มิกซ์ 1 กก.

ตรวจสอบผลลัพธ์การค้นหา มีโอ อาหารแมว ปลาทูน่า
    Wait Until Element Is Visible    xpath=${name_product}
    Element Should Contain    xpath=${name_product}    มีโอ อาหารแมว ปลาทูน่า 1 กก.

เลือกสินค้า ซอยแคท
    Click Element    xpath=//*[@id="btn-accept-gdpr"]
    Click Element    xpath=${name_product}

เลือกสินค้า มีโอ
    Click Element    xpath=${name_product}

เพิ่มจำนวนสินค้า ซอยแคท จำนวน 2 ชิ้น
    Wait Until Element Is Visible    xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Element Attribute Value Should Be    xpath=//*[@id="article-form"]/div[2]/div[2]/div[1]/input    attribute=value    expected=2

กดเพิ่มลงตะกร้า
    Wait Until Element Is Visible    xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button
    Click Element  xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[1]/button

กดชำระค่าสินค้า
    Wait Until Element Is Visible    xpath=//*[@id="mini-basket-val"]/li[5]/a[2]
    Click Element  xpath=//*[@id="mini-basket-val"]/li[5]/a[2]

login ข้อมูลส่วนตัว
    Input Text    name=email    xxx@gmail.com
    Input Text    name=password    xxx1234
    Click Element    xpath=//*[@id="__next"]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]

เลือกจัดส่งที่ร้าน7-11
    Wait Until Element Is Visible    xpath=//*[@id="address-tabs"]/ul/li[1]/a
    Click Element    xpath=//*[@id="address-tabs"]/ul/li[1]/a
    Click Element    xpath=//*[@id="storefinder-selector-group"]/div[1]/div/button
    Input Text    id=user-storenumber-input    04811
    Wait Until Element Is Visible    xpath=//*[@id="store"]/div[2]/div/div[4]/div[3]
    Click Element    id=btn-check-storenumber

ดำเนินการชำระเงิน
    Wait Until Element Is Visible    id=continue-payment-btn
    Click Button    id=continue-payment-btn

เลือกชำระเงินด้วยทรูมันนี่ วอลเล็ท
    Click Element    xpath=//*[@id="payment-options"]/div[2]/button
    Input Text    id=checkoutData.paymentData.trueMoneyMobileNumber    066-543-1150
    Press Keys    None    RETURN

ตรวจสอบสรุุปรายการสั่งซื้อ
    #ที่อยู่จัดส่งสินค้า
    Element Should Contain    xpath=${check_order}    ปองภพ รัตนาอรุณ
    Element Should Contain    xpath=${check_order}    เบอร์โทรศัพท์ผู้รับสินค้า: 066-543-1150
    Element Should Contain    xpath=${check_order}    เซเว่นอีเลฟเว่น #04811 สาขา สวนสยามซอย 1
    ...                                               เลขที่ ถ.สวนสยาม, 37,39, แขวงคันนายาว เขตคันนายาว กรุงเทพฯ 10230
    #รายละเอียดสินค้า
    Element Should Contain    xpath=${check_order}    ซอยแคท อาหารแมว 1 มิกซ์ 1 กก. 2 ฿ 138
    Element Should Contain    xpath=${check_order}    มีโอ อาหารแมว ปลาทูน่า 1 กก. 1 ฿ 126
    Element Should Contain    xpath=${check_order}    ราคา ฿ 264
    Element Should Contain    xpath=${check_order}    ค่าจัดส่ง ฟรี
    Element Should Contain    xpath=${check_order}    ยอดสุทธิ (รวมภาษีมูลค่าเพิ่ม) ฿ 264
    Element Should Contain    xpath=${check_order}    รับ ALL member Point (คะแนน)
    ...                                               (ได้รับเมื่อชำระเงินสำเร็จ) 78
    Click Element    xpath=//*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button
