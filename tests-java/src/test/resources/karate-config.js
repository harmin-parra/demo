function fn() {

  var headless = 'true';
  var browser = 'chrome';
  
  var config = {
    url_form_page: 'https://www.selenium.dev/selenium/web/web-form.html',
    url_ajax_page: 'http://qa-demo.gitlab.io/reports/web/ajax.html',
    url_rest_api: 'https://petstore.swagger.io/v2/pet',
  };

  headless = karate.properties['headless'] || headless;
  browser = karate.properties['browser'].toLowerCase() || browser;
  
  if( browser != "firefox" && browser != "chrome" )
    throw new Error("Invalid 'browser' parameter value: " + browser);

  if( headless == "true" ) {
    if( browser == "firefox" )
      karate.configure('driver', { type: 'geckodriver', executable: '/opt/webdriver/geckodriver', webDriverSession: { capabilities: { alwaysMatch: {browserName: 'firefox', "moz:firefoxOptions": { args: ['--headless'] } } } } });
    else
      karate.configure('driver', { type: 'chromedriver', executable: '/opt/webdriver/chromedriver', webDriverSession: { capabilities: { alwaysMatch: {browserName: 'chrome', "goog:chromeOptions": { args: ['headless'] } } } } });
  } else {
    if( browser == "firefox" )
      karate.configure('driver', { type: 'geckodriver', executable: '/opt/webdriver/geckodriver' });
    else
      karate.configure('driver', { type: 'chromedriver', executable: '/opt/webdriver/chromedriver' });
  }

  karate.log('browser =', browser);
  karate.log('headless =', headless);

  return config;
}
