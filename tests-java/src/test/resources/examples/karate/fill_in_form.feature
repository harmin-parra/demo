@ignore
Feature: Fill-in Web form page

  #Background:
  #  * driver url_form_page

  Scenario:
    * input('#my-text-id', #(login))
    * input('input[name=my-password]', #(password))
    * input('textarea[name=my-textarea]', "#(text)")
    * select('select[name=my-select]', #(number))
    # * if (browser = 'chrome') driver.inputFile('input[name=my-file]', '../../file.txt')
    * input('input[name=my-datalist]', #(city))
    * script("document.getElementsByName('my-colors')[0].value = #(color);")
    * script("document.getElementsByName('my-date')[0].value = #(date);")
    * click('//body')
    * script("document.getElementsByName('my-range')[0].value = #(range);")
