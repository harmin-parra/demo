package cucumber.calculator;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import static org.junit.jupiter.api.Assertions.assertEquals;

import cucumber.calculator.Calculator;

public class CalculatorStep {

    private Calculator calculator;
    private int result;

    @Given("I have a calculator")
    public void setup() {
        calculator = new Calculator();
    }

    @When("I add {int} and {int}")
    public void add(int x, int y) {
        this.result = calculator.add(x, y);
    }

    @Then("the calculator returns {int}")
    public void sum(int s) {
        assertEquals(this.result, s);
    }

}
