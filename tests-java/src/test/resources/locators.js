function(page, element) {
  
  var locators = {
    form_page: {
      input: '#my-text-id',
      password: 'input[name=my-password]',
      textarea: 'textarea[name=my-textarea]',
      number: 'select[name=my-select]',
      city: 'input[name=my-datalist]',
      color: 'input[name=my-colors]',
      date: 'input[name=my-date]',
      range: 'input[name=my-range]',
      file: 'input[name=my-file]',
      button: 'button',
    },

    ajax_page: {
      button: '#button',
      title: '#title',
    },
  };

  return locators[page][element];
}
