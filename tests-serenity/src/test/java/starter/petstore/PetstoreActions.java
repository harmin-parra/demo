package starter.petstore;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.http.ContentType;
import io.restassured.mapper.ObjectMapperType;
import net.serenitybdd.core.steps.UIInteractions;
import org.hamcrest.Matchers;
import java.util.HashMap;
import java.util.Map;
import org.junit.jupiter.api.Assertions;
import static net.serenitybdd.rest.SerenityRest.*;

public class PetstoreActions extends UIInteractions {

    private static Pet pet = null;

    @Given("I have a pet store")
    public void givenPetstoreExits() { }

    @Given("A pet exists in the store")
    public void givenPetExists() {
        Assertions.assertNotNull(this.pet);
    }

    @When("I add a pet")
    public Pet whenIAddPet() {
        Map<String, Object> payload = new HashMap<String, Object>();
        payload.put("id", 543);
        payload.put("name", "Cookie");
        payload.put("status", "sold");

        this.pet = given()
            .baseUri("https://petstore.swagger.io")
            .basePath("/v2/pet")
            .body(payload)
            .accept(ContentType.JSON)
            .contentType(ContentType.JSON).post().getBody().as(Pet.class, ObjectMapperType.GSON);
        return this.pet;
    }

    @When("I query an existing pet")
    public Pet whenIGetPet() {
        return when().get("/" + this.pet.getId()).getBody().as(Pet.class, ObjectMapperType.GSON);
    }

    @Then("The pet is added")
    public void thenPetIsAdded() {
        Assertions.assertNotNull(this.pet);
    }

    @Then("I get the pet information")
    public void thenIGetPetInfo() {
        then().body("id", Matchers.equalTo(this.pet.getId()));
    }

    @When("I delete a pet")
    public void whenIDeletePet() {
        given()
            .baseUri("https://petstore.swagger.io")
            .basePath("/v2/pet")
            .accept(ContentType.JSON)
            .contentType(ContentType.JSON)
            .delete("/" + this.pet.getId())
        .then()
            .body("message", Matchers.equalTo(String.valueOf(this.pet.getId())));
    }

    @Then("The pet is deleted")
    public void thenPetIsDeleted() {
        when()
            .get("/" + this.pet.getId())
        .then()
            .body("message", Matchers.equalTo("Pet not found"));
    }

}
