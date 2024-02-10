package cucumber.petstore;

import io.qameta.allure.Allure;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

import org.apache.hc.core5.http.io.entity.StringEntity;
import org.json.simple.JSONObject;

import cucumber.petstore.Petstore;

public class PetstoreSteps {

    private static Petstore store;
    private int id = 530;
    private static JSONObject result;

    @Given("I have a pet store")
    public void i_have_a_pet_store() {
        this.store = new Petstore();
    }

    @When("I add a pet")
    public void i_add_a_pet() {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":" + String.valueOf(this.id) + ",");
        json.append("\"name\":\"Cookie\",");
        json.append("\"status\":\"sold\"");
        json.append("}");
        StringEntity data = new StringEntity(json.toString());
        Object[] result = this.store.add(data);
        assertNotEquals(result, null);
        assertNotEquals(result[0], null);
        assertNotEquals(result[1], null);
        assertEquals(result[0], 200);
    }

    @Then("The pet is added")
    public void the_pet_is_added() {
        this.i_query_an_existing_pet();
    }

    @Given("A pet exists in the store")
    public void a_pet_exists_in_the_store() {
        this.i_query_an_existing_pet();
    }

    @When("I delete a pet")
    public void i_delete_a_pet() {
        Object[] result = this.store.delete(this.id);
        assertNotEquals(result, null);
        assertNotEquals(result[0], null);
        assertNotEquals(result[1], null);
        assertEquals(result[0], 200);
    }

    @Then("The pet is deleted")
    public void the_pet_is_deleted() {
        Object[] result = this.store.get(this.id);
        assertNotEquals(result, null);
        assertNotEquals(result[0], null);
        assertNotEquals(result[1], null);
        assertEquals(result[0], 404);
        assertEquals(((JSONObject)result[1]).get("type"), "error");
        assertEquals(((JSONObject)result[1]).get("message"), "Pet not found");
    }

    @When("I query an existing pet")
    public void i_query_an_existing_pet() {
        Object[] result = this.store.get(this.id);
        assertNotEquals(result, null);
        assertNotEquals(result[0], null);
        assertNotEquals(result[1], null);
        assertEquals(result[0], 200);
        this.result = (JSONObject) result[1];
    }

    @Then("I get the pet information")
    public void i_get_the_pet_information() {
        assertEquals(this.result.get("id").toString(), String.valueOf(this.id));
        assertEquals(this.result.get("name"), "Cookie");
        assertEquals(this.result.get("status"), "sold");
    }

}
