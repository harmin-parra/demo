Feature: Cucumber

  Scenario Outline: Calculator - Addition
    Given I have a calculator
    When I add <x> and <y>
    Then the calculator returns <sum>

    Examples:
      |  x  |  y | sum |
      |  1  |  1 |  2  |
      |  2  |  1 |  3  |
      |  2  |  7 |  9  |
